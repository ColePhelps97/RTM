package org.colephelps.rtm;

import java.sql.*;
import java.util.ArrayList;
import java.util.Properties;
import java.util.UUID;

public class Switch {
    protected String name;
    protected Double xCoord;
    protected Double yCoord;
    protected Double zCoord;
    protected Track inTrack;
    protected Track outTrack1;
    protected Track outTrack2;
    protected Integer turnType;
    protected String additionalProperties;
    protected UUID id;

    public Switch(String name, Double xCoord, Double yCoord, Double zCoord,
                  Track inTrack, Track outTrack1, Track outTrack2,
                  Integer turnType, String additionalProperties) {
        this.name = name;
        this.xCoord = xCoord;
        this.yCoord = yCoord;
        this.zCoord = zCoord;
        this.inTrack = inTrack;
        this.outTrack1 = outTrack1;
        this.outTrack2 = outTrack2;
        this.turnType = turnType;
        this.additionalProperties = additionalProperties;
    }

    public Double getxCoord() {
        return xCoord;
    }

    public Double getyCoord() {
        return yCoord;
    }

    public Double getzCoord() {
        return zCoord;
    }

    public Track getInTrack() {
        return inTrack;
    }

    public Track getOutTrack1() {
        return outTrack1;
    }

    public Track getOutTrack2() {
        return outTrack2;
    }

    public Integer getTurnType() {
        return turnType;
    }

    public String getAdditionalProperties() {
        return additionalProperties;
    }

    public void addToDB() throws SQLException {
        Connection conn = DBConnection.getPostgresConnection();

        Statement addSwitchStatement = conn.createStatement();

        String query = "SELECT addSwitch('" + this.name + "', " +
                "'baseNetwork', NULL, NULL, '" + this.name + "_location', 'both', "+
                (this.xCoord == null?"NULL":this.xCoord.toString()) + ", " +
                (this.yCoord == null?"NULL":this.yCoord.toString()) + ", " +
                (this.zCoord == null?"NULL":this.zCoord.toString()) + ", " +
                "'GPS', " +
                (this.turnType == null?"NULL":this.turnType.toString()) + ", " +
                (this.additionalProperties == null?"NULL":this.additionalProperties) +
                ");";

        try {
            System.out.println(query);
            ResultSet addSwitchId = addSwitchStatement.executeQuery(query);
            //addSwitchId.next();
            this.id = (UUID)addSwitchId.getObject("addSwitch");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public static ArrayList<Switch> getSwitches() throws SQLException {
        ArrayList<Switch> switches = new ArrayList<Switch>();


        Connection con = DBConnection.getLiteConnection();

        Statement getSwitch = con.createStatement();
        ResultSet switchesResult = getSwitch.executeQuery("SELECT ID, ID_CENTER_GEO_POINT, ID_GEO_LINE_START, " +
                "ID_GEO_LINE_END, ID_GEO_LINE_TURN, TURN_TYPE, ADDITIONAL_PROPERTIES " +
                "FROM RAILWAY_OBJ_SINGLE_SWITCH;"
        );



        while(switchesResult.next()) {
            Statement switchPointStatement = con.createStatement();
            int a = switchesResult.getInt("ID_CENTER_GEO_POINT");
            ResultSet switchPoint = switchPointStatement.executeQuery(
                    "SELECT LATITUDE_DEG, LONGITUDE_DEG " +
                    "FROM GEO_POINT " +
                    "WHERE ID=" + a
            );

            Statement getSwitchName = con.createStatement();
            ResultSet switchName = getSwitchName.executeQuery(
                    "SELECT NAME " +
                            "FROM RAILWAY_OBJ " +
                            "WHERE ID=" + switchesResult.getInt("ID") + ";");

            switches.add(new Switch(
                    switchName.getString("NAME"),
                    switchPoint.getDouble("LATITUDE_DEG"),
                    switchPoint.getDouble("LONGITUDE_DEG"),
                    null,
                    Track.loadTrackByID(switchesResult.getInt("ID_GEO_LINE_START")),
                    Track.loadTrackByID(switchesResult.getInt("ID_GEO_LINE_END")),
                    Track.loadTrackByID(switchesResult.getInt("ID_GEO_LINE_TURN")),
                    switchesResult.getInt("TURN_TYPE"),
                    switchesResult.getString("ADDITIONAL_PROPERTIES")
            ));
        }

        return switches;
    }

    public void addTracks() throws SQLException {
        String switchName, inTrackName, outTrack1Name, outTrack2Name;
        Connection conn = DBConnection.getPostgresConnection();


        //SWITCH NAME
        Statement getSwitchName = conn.createStatement();
        ResultSet switchNameResult = getSwitchName.executeQuery(
                "SELECT name " +
                "FROM BaseObject " +
                "WHERE id='" + this.id + "';"
        );
        switchNameResult.next();
        switchName = switchNameResult.getString("name");
        //INTRACK NAME
        Statement getInTrackName = conn.createStatement();
        ResultSet inTrackNameResult = getSwitchName.executeQuery(
                "SELECT name " +
                "FROM BaseObject " +
                "WHERE id='" + inTrack.id + "';"
        );
        inTrackNameResult.next();
        inTrackName = inTrackNameResult.getString("name");
        //OUTTRACK1
        Statement getOutTrack1Name = conn.createStatement();
        ResultSet outTrack1NameResult = getSwitchName.executeQuery(
                "SELECT name " +
                "FROM BaseObject " +
                "WHERE id='" + outTrack1.id + "';"
        );
        outTrack1NameResult.next();
        outTrack1Name = outTrack1NameResult.getString("name");
        //OUTTRACK2
        Statement getOutTrack2Name = conn.createStatement();
        ResultSet outTrack2NameResult = getSwitchName.executeQuery(
                "SELECT name " +
                "FROM BaseObject " +
                "WHERE id='" + outTrack2.id + "';"
        );
        outTrack2NameResult.next();
        outTrack2Name = outTrack2NameResult.getString("name");
        //RELATION
        Statement addRelationStatement = conn.createStatement();
        String query = "SELECT connectTracksToSwitch('" + switchName + "', '" + inTrackName + "', '" +
                outTrack1Name + "', '" + outTrack2Name + "', 'baseNetwork');";

        try {
            System.out.println(query);
            ResultSet addRelationId = addRelationStatement.executeQuery(query);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

    }
}
