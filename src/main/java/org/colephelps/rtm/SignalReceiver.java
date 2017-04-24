package org.colephelps.rtm;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.UUID;

public class SignalReceiver {
    protected UUID id;
    protected UUID generatorId;
    protected String name;
    protected String additionalProperties;
    protected Integer generatorOldId;
    protected Integer geoPointId;
    protected Integer oldId;
    protected ArrayList<SignalReceiver> addedSignalReceivers = new ArrayList<SignalReceiver>();

    public SignalReceiver(String name, String additionalProperties, Integer geoPointId, Integer oldId, Integer generatorOldId) {
        this.name = name;
        this.additionalProperties = additionalProperties;
        this.geoPointId = geoPointId;
        this.oldId = oldId;
        this.generatorOldId = generatorOldId;
    }

    public SignalReceiver getSignalReceiverInfo(Integer geoPointId) throws SQLException {
        Connection con = DBConnection.getLiteConnection();

        Statement getSignalReceiver = con.createStatement();
        ResultSet signalReceiver = getSignalReceiver.executeQuery(
                "SELECT ID, ID_GEO_POINT, ID_RAILWAY_OBJ_SIGNAL_GENERATOR, ADDITIONAL_PROPERTIES " +
                        "FROM RAILWAY_OBJ_SIGNAL_RECEIVER " +
                        "WHERE ID_GEO_POINT = " + geoPointId + ";"
        );

        Boolean hasResult = signalReceiver.next();
        if(hasResult) {
            //Get name from RAILWAY_OBJ
            Statement getSignalReceiverName = con.createStatement();
            ResultSet signalReceiverName = getSignalReceiverName.executeQuery(
                    "SELECT NAME " +
                            "FROM RAILWAY_OBJ " +
                            "WHERE ID =" + signalReceiver.getInt("ID") + ";"
            );

            SignalReceiver s = new SignalReceiver(
                    signalReceiverName.next() ? signalReceiverName.getString("NAME") : null,
                    signalReceiver.getString("ADDITIONAL_PROPERTIES"),
                    signalReceiver.getInt("ID_GEO_POINT"),
                    signalReceiver.getInt("ID"),
                    signalReceiver.getInt("ID_RAILWAY_OBJ_SIGNAL_GENERATOR")
            );
            return s;
        } else
            return null;
    }

    public void addSignalReceiverToDB(UUID pointId) throws SQLException {
        SignalGenerator generator = SignalGenerator.getGeneratorByOldId(this.generatorOldId);
        if(generator == null) return;
        Statement addSignalReceiver = DBConnection.getPostgresConnection().createStatement();
        ResultSet signalReceiverId = addSignalReceiver.executeQuery(
                "PERFORM addSignalReceiver('" + pointId.toString() + "', " +
                        "'" + generator.id + "'" + ", " +
                        "'" + this.additionalProperties + "');"
        );

        this.id = (UUID)signalReceiverId.getObject("addSignalReceiver");
        addedSignalReceivers.add(this);
    }
}
