package org.colephelps.rtm;

import java.sql.*;
import java.util.ArrayList;
import java.util.UUID;

public class TrackPoint {
    protected UUID id;
    protected Double x;
    protected Double y;
    protected Double z;
    protected Track track;
    protected Integer index;
    protected Signal signal;
    protected Integer geoPointId;
    private static int i = 1;

    public TrackPoint(Track track, Integer geoPointId, Integer index, Double x, Double y, Double z) {
        this.geoPointId = geoPointId;
        this.track = track;
        this.index = index;
        this.x = x;
        this.y = y;
        this.z = z;
    }


    public void addTrackPointToDB() {
        try {
            Statement addTrackPointStatement = DBConnection.getPostgresConnection().createStatement();
            ResultSet addTrackPoint = addTrackPointStatement.executeQuery(
                    "SELECT addTrackPoint('track_point_" + i + "', " +
                            "'baseNetwork', " +
                            "NULL, " +
                            "NULL, " +
                            "'track_point_" + i + "_location', " +
                            "'both', " +
                            this.x + ", " +
                            this.y + ", " +
                            this.z + ", " +
                            "'GPS', " +
                            "'" + this.track.getName() + "', " +
                            this.index + ");"
            );
            i++;

            addTrackPoint.next();
            this.id = (UUID)addTrackPoint.getObject("addTrackPoint");
            try {
                if (this.signal != null && this.signal.geoPointId == this.geoPointId) {
                    this.signal.addSignalToDB(this.id);
                }
            } catch(SQLException e) {
                e.printStackTrace();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public static ArrayList<TrackPoint> getTrackPoints(Track track) throws SQLException {
        ArrayList<TrackPoint> trackPoints = new ArrayList<TrackPoint>();
        Integer maxIndex = 0;

        TrackPoint tp1 = new TrackPoint(
                track,
                track.geoPointStartId,
                0,
                track.getStartXCoord(),
                track.getStartYCoord(),
                track.getStartZCoord()
        );

        tp1.signal = Signal.getSignalInfo(tp1.geoPointId);

        trackPoints.add(tp1);

        Connection con = DBConnection.getLiteConnection();

        Statement getAddPoints = con.createStatement();
        ResultSet addPointsId = getAddPoints.executeQuery(
                "SELECT ID_GEO_POINT, POINT_INDEX " +
                "FROM GEO_LINE_ADDITIONAL_POINTS " +
                "WHERE ID_GEO_LINE = " + track.oldId + ";"
        );

        while(addPointsId.next()) {
            maxIndex = maxIndex < addPointsId.getInt("POINT_INDEX") ? addPointsId.getInt("POINT_INDEX") : maxIndex;
            Statement getAddPointCoordinates = con.createStatement();
            ResultSet pointCoord = getAddPointCoordinates.executeQuery(
                    "SELECT LATITUDE_DEG, LONGITUDE_DEG " +
                    "FROM GEO_POINT " +
                    "WHERE ID = " + addPointsId.getInt("ID_GEO_POINT") + ";"
            );

            Integer a = addPointsId.getInt("ID_GEO_POINT");
            System.out.println(addPointsId.getInt("ID_GEO_POINT") + a);

            TrackPoint tp2 = new TrackPoint(
                    track,
                    a,
                    addPointsId.getInt("POINT_INDEX"),
                    pointCoord.getDouble("LATITUDE_DEG"),
                    pointCoord.getDouble("LONGITUDE_DEG"),
                    null
            );

            tp2.signal = Signal.getSignalInfo(tp2.geoPointId);

            trackPoints.add(tp2);
        }

        TrackPoint tp3 = new TrackPoint(
                track,
                track.geoPointEndId,
                maxIndex + 1,
                track.getEndXCoord(),
                track.getEndYCoord(),
                track.getEndZCoord()
        );

        tp3.signal = Signal.getSignalInfo(tp3.geoPointId);

        trackPoints.add(tp3);

        return trackPoints;
    }
}
