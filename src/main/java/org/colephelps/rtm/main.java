package org.colephelps.rtm;

import java.sql.*;
import java.util.ArrayList;
import java.util.Properties;


public class main {
    public static void main(String args[]) throws SQLException {
        ArrayList<Switch> switches = Switch.getSwitches();
        for(Switch sweatch : switches) {
            sweatch.addToDB();
            sweatch.getInTrack().addTrackToDB();
            sweatch.getInTrack().addTrackPointsToDB();
            sweatch.getOutTrack1().addTrackToDB();
            sweatch.getOutTrack1().addTrackPointsToDB();
            sweatch.getOutTrack2().addTrackToDB();
            sweatch.getOutTrack2().addTrackPointsToDB();
            sweatch.addTracks();

            /*String url = "jdbc:postgresql://localhost/railtopomodel";
            Properties props = new Properties();
            props.setProperty("user","postgres");
            props.setProperty("password","postgres");
            Connection conn = DriverManager.getConnection(url, props);

            Statement createRelationStatement = conn.createStatement();
            ResultSet createPosRelation = createRelationStatement.executeQuery(
                    "SELECT connectTracksToSwitch"
            )*/
        }
    }
}
