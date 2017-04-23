package org.colephelps.rtm;

import java.sql.*;
import java.util.ArrayList;
import java.util.Properties;
import java.util.UUID;

import static org.colephelps.rtm.TrackPoint.getTrackPoints;

public class Track {
    protected String name;
    protected Double startXCoord;
    protected Double startYCoord;
    protected Double startZCoord;
    protected Double endXCoord;
    protected Double endYCoord;
    protected Double endZCoord;
    protected Integer geoPointStartId;
    protected Integer geoPointEndId;
    protected String additionalProperties;
    protected UUID id;
    protected Integer oldId;

    private static int i = 10;
    public Double getStartXCoord() {
        return startXCoord;
    }

    public Double getStartYCoord() {
        return startYCoord;
    }

    public Double getStartZCoord() {
        return startZCoord;
    }

    public Double getEndXCoord() {
        return endXCoord;
    }

    public Double getEndYCoord() {
        return endYCoord;
    }

    public Double getEndZCoord() {
        return endZCoord;
    }

    public String getAdditionalProperties() {
        return additionalProperties;
    }

    public UUID getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public Track(String name, Double startXCoord, Double startYCoord, Double startZCoord,
                 Double endXCoord, Double endYCoord, Double endZCoord,
                 String additionalProperties, Integer oldId, Integer geoPointStartId, Integer geoPointEndId) {
        this.name = name;
        this.startXCoord = startXCoord;
        this.startYCoord = startYCoord;
        this.startZCoord = startZCoord;
        this.endXCoord = endXCoord;
        this.endYCoord = endYCoord;
        this.endZCoord = endZCoord;
        this.additionalProperties = additionalProperties;
        this.oldId = oldId;
        this.geoPointStartId = geoPointStartId;
        this.geoPointEndId = geoPointEndId;
    }

    public void addTrackToDB() {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            System.out.print(e.getMessage() + "ERROR");
            return;
        }
        try {
            Connection conn = DBConnection.getPostgresConnection();

            Statement addTrackStatement = conn.createStatement();
            ResultSet addTrackId = addTrackStatement.executeQuery(
                    "SELECT addTrack('" + /*track_" + i +*/this.name + "', " +
                            "'baseNetwork', NULL, NULL, '" + /*track_" + i + */this.name + "_location', 'both', " +
                            (this.startXCoord == null ? "NULL" : this.startXCoord) + ", " +
                            (this.startYCoord == null ? "NULL" : this.startYCoord) + ", " +
                            (this.startZCoord == null ? "NULL" : this.startZCoord) + ", " +
                            (this.endXCoord == null ? "NULL" : this.endXCoord) + ", " +
                            (this.endYCoord == null ? "NULL" : this.endYCoord) + ", " +
                            (this.endZCoord == null ? "NULL" : this.endZCoord) + ", " +
                            "'GPS', " +
                            (this.additionalProperties == null ? "NULL" : this.additionalProperties) +
                            ");");
            addTrackId.next();
            this.id = (UUID)addTrackId.getObject("addTrack");

        } catch (SQLException e) {
            System.out.println(e.getMessage() + "ERROR");
        }
    }

    public static Track loadTrackByID(int id) throws SQLException {
        Connection con = DBConnection.getLiteConnection();

        Statement circuitStatement = con.createStatement();
        ResultSet circuitProps = circuitStatement.executeQuery(
                "SELECT ID, ADDITIONAL_PROPERTIES " +
                "FROM RAILWAY_OBJ_CIRCUIT " +
                "WHERE ID_GEO_LINE="+id+";");

        /*Integer trackId = circuitProps.getInt("ID");*/


        Statement geolineStatement = con.createStatement();
        ResultSet geolineSet  = geolineStatement.executeQuery(
                "SELECT ID_GEO_POINT_START, ID_GEO_POINT_END " +
                "FROM GEO_LINE WHERE ID=" + id);

        Statement geopointStartStatement = con.createStatement();
        ResultSet geopointStartSet = geopointStartStatement.executeQuery(
                "SELECT LATITUDE_DEG, LONGITUDE_DEG FROM GEO_POINT " +
                "WHERE ID="+geolineSet.getInt("ID_GEO_POINT_START"));

        Statement geopointEndStatement = con.createStatement();
        ResultSet geopointEndSet = geopointEndStatement.executeQuery(
                "SELECT LATITUDE_DEG, LONGITUDE_DEG FROM GEO_POINT " +
                "WHERE ID="+geolineSet.getInt("ID_GEO_POINT_END"));

        /*Statement getTrackName = con.createStatement();
        ResultSet trackName = getTrackName.executeQuery(
                "SELECT NAME " +
                "FROM RAILWAY_OBJ " +
                "WHERE ID=" + trackId + ";");*/
        i++;

        return new Track(
                //trackName.getString("NAME"),
                "track"+i,
                geopointStartSet.getDouble("LATITUDE_DEG"),
                geopointStartSet.getDouble("LONGITUDE_DEG"),
                null,
                geopointEndSet.getDouble("LATITUDE_DEG"),
                geopointEndSet.getDouble("LONGITUDE_DEG"),
                null,
                //circuitProps.getString("ADDITIONAL_PROPERTIES")
                null,
                id,
                geolineSet.getInt("ID_GEO_POINT_START"),
                geolineSet.getInt("ID_GEO_POINT_END")
        );
    }

    public void addTrackPointsToDB() throws SQLException {
        ArrayList<TrackPoint> points = TrackPoint.getTrackPoints(this);
        for(TrackPoint point : points)
            point.addTrackPointToDB();
    }
}
