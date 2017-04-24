package org.colephelps.rtm;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.UUID;

public class SignalGenerator {
    protected Integer frequency;
    protected String name;
    protected String generatorType;
    protected String additionalProperties;
    protected Integer geoPointId;

    public SignalGenerator(String name, String generatorType, Integer frequency, String additionalProperties, Integer geoPointId) {
        this.name = name;
        this.generatorType = generatorType;
        this.frequency = frequency;
        this.additionalProperties = additionalProperties;
        this.geoPointId = geoPointId;
    }

    public static SignalGenerator getSignalGeneratorInfo(Integer idGeoPoint) throws SQLException {
        Connection con = DBConnection.getLiteConnection();

        Statement getSignalPoint = con.createStatement();
        ResultSet signalGeneratorInfo = getSignalPoint.executeQuery(
                "SELECT ID, ID_GEO_POINT, ID_TYPE, FREQUENCY, ADDITIONAL_PROPERTIES " +
                        "FROM RAILWAY_OBJ_SIGNAL_GENERATOR " +
                        "WHERE ID_GEO_POINT = " + idGeoPoint + ";"
        );

        Boolean hasResult = signalGeneratorInfo.next();
        //System.out.println(hasResult);
        if(hasResult) {
            //System.out.println(signalGeneratorInfo.getInt("ID_GEO_POINT"));
            //Get generator type from RAILWAY_OBJ_SIGNAL_GENERATOR_TYPE table
            Statement getSignalGeneratorType = con.createStatement();
            ResultSet signalGeneratorType = getSignalGeneratorType.executeQuery(
                    "SELECT NAME " +
                            "FROM RAILWAY_OBJ_SIGNAL_GENERATOR_TYPE " +
                            "WHERE ID =" + signalGeneratorInfo.getInt("ID_TYPE") + ";"
            );

            //Get name from RAILWAY_OBJ
            Statement getSignalGeneratorName = con.createStatement();
            ResultSet signalGeneratorName = getSignalGeneratorName.executeQuery(
                    "SELECT NAME " +
                            "FROM RAILWAY_OBJ " +
                            "WHERE ID =" + signalGeneratorInfo.getInt("ID") + ";"
            );
            SignalGenerator s = new SignalGenerator(
                    signalGeneratorName.next() ? signalGeneratorName.getString("NAME") : null,
                    signalGeneratorType.next() ? signalGeneratorType.getString("NAME") : null,
                    signalGeneratorInfo.getInt("FREQUENCY"),
                    signalGeneratorInfo.getString("ADDITIONAL_PROPERTIES"),
                    signalGeneratorInfo.getInt("ID_GEO_POINT")
            );
            return s;
        } else
            return null;
    }

    public void addSignalGeneratorToDB(UUID pointId) throws SQLException {
        Statement addSignalGenerator = DBConnection.getPostgresConnection().createStatement();
        ResultSet signalId = addSignalGenerator.executeQuery(
                "PERFORM addSignalGenerator('" + pointId.toString() + "', " +
                        (this.generatorType == null ? "NULL" : "'" + this.generatorType + "'") + ", " +
                        (this.frequency == null ? "NULL" : "'" + this.frequency.toString() + "'") + ", " +
                        "'" + this.additionalProperties + "');"
        );

    }
}
