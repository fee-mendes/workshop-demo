CREATE KEYSPACE IF NOT EXISTS iot WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};
CREATE TABLE IF NOT EXISTS iot.devices (
   device_id uuid,
   ts timestamp,
   temperature float,
   pressure float,
   humidity float,
   is_active boolean,
   PRIMARY KEY(device_id, ts));
