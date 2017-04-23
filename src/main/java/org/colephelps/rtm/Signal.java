package org.colephelps.rtm;

import com.sun.org.apache.regexp.internal.RESyntaxException;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.UUID;

public class Signal {
    protected String signalType;
    protected Boolean isNominalDirection;
    protected String additionalProperties;
    protected Integer geoPointId;

    public Signal(String signalType, Boolean isNominalDirection, String additionalProperties, Integer geoPointId) {
        this.signalType = signalType;
        this.isNominalDirection = isNominalDirection;
        this.additionalProperties = additionalProperties;
        this.geoPointId = geoPointId;
    }

    public static Signal getSignalInfo(Integer idGeoPoint) throws SQLException {
        Connection con = DBConnection.getLiteConnection();

        Statement getSignalPoint = con.createStatement();
        ResultSet signalInfo = getSignalPoint.executeQuery(
                "SELECT ID_GEO_POINT, IS_NOMINAL_DIRECTION, SIGNAL_TYPE, ADDITIONAL_PROPERTIES " +
                "FROM RAILWAY_OBJ_SIGNAL " +
                "WHERE ID_GEO_POINT = " + idGeoPoint + ";"
        );

        Boolean hasResult = signalInfo.next();
        System.out.println(hasResult);
        if(hasResult) {
            System.out.println(signalInfo.getInt("ID_GEO_POINT"));
            Statement getSignalType = con.createStatement();
            ResultSet signalType = getSignalType.executeQuery(
                    "SELECT NAME " +
                    "FROM RAILWAY_OBJ_SIGNAL_TYPE " +
                    "WHERE ID =" + signalInfo.getInt("SIGNAL_TYPE") + ";"
            );
            Signal s = new Signal(
                    signalType.next() ? signalType.getString("NAME") : null,
                    signalInfo.getBoolean("IS_NOMINAL_DIRECTION"),
                    signalInfo.getString("ADDITIONAL_PROPERTIES"),
                    signalInfo.getInt("ID_GEO_POINT")
            );
            return s;
        } else return null;
    }

    public void addSignalToDB(UUID id) throws SQLException {
        Statement addSignal = DBConnection.getPostgresConnection().createStatement();
        ResultSet signalId = addSignal.executeQuery(
                "PERFORM addSignal('" + id + "', " + (this.isNominalDirection ? "'t', " : "'f', ") +
                        (this.signalType == null ? "NULL" : "'" + this.signalType + "'") + ", '" +
                        this.additionalProperties + "');"
        );

    }
}
