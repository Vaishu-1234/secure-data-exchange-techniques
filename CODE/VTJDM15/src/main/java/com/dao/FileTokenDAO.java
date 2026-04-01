package com.dao;

import java.sql.*;
import java.util.*;
import java.util.function.Function;

public class FileTokenDAO {
    private static final String INSERT_SQL =
        "INSERT INTO file_tokens(batch_id, token_index, original_value, encrypted_value, data_value, unique_key) VALUES (?,?,?,?,?,?)";

    // Save all tokens in a batch + store "data"
    public void saveBatch(String batchId, List<String> tokens, String data,
                          Function<String, String> encryptor) throws Exception {
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(INSERT_SQL)) {

            int idx = 1;
            for (String t : tokens) {
                String original = (t == null) ? "" : t.trim();
                String encrypted = encryptor.apply(original);

                // Generate a random 16-digit key
                String uniqueKey = generate16DigitKey();

                ps.setString(1, batchId);
                ps.setInt(2, idx++);
                ps.setString(3, original);
                ps.setString(4, encrypted);
                ps.setString(5, data);       // store data param
                ps.setString(6, uniqueKey);  // store unique 16-digit key

                ps.addBatch();
            }
            ps.executeBatch();
        }
    }
    
    
    public void saveSingle(String batchId, int tokenIndex, String original, String dataValue,
            Function<String, String> encryptor) throws Exception {
try (Connection con = DBUtil.getConnection();
PreparedStatement ps = con.prepareStatement(INSERT_SQL)) {

String encrypted = encryptor.apply(original);
String uniqueKey = generate16DigitKey();

ps.setString(1, batchId);
ps.setInt(2, tokenIndex);
ps.setString(3, original);
ps.setString(4, encrypted);
ps.setString(5, dataValue);  // Here we store "Temperature", "Humidity", "Pressure", "Light"
ps.setString(6, uniqueKey);

ps.executeUpdate();
}
}

    // Utility method to generate 16-digit numeric key
    private String generate16DigitKey() {
        Random random = new Random();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 16; i++) {
            sb.append(random.nextInt(10)); // only digits 0-9
        }
        return sb.toString();
    }

    public List<Map<String, Object>> fetchByBatch(String batchId) throws Exception {
        String sql = "SELECT token_index, original_value, encrypted_value, data_value, unique_key " +
                     "FROM file_tokens WHERE batch_id=? ORDER BY token_index";

        List<Map<String, Object>> list = new ArrayList<>();

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, batchId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("token_index", rs.getInt("token_index"));
                    row.put("original_value", rs.getString("original_value"));
                    row.put("encrypted_value", rs.getString("encrypted_value"));
                    row.put("data_value", rs.getString("data_value"));
                    row.put("unique_key", rs.getString("unique_key"));
                    list.add(row);
                }
            }
        }
        return list;
    }
    
    
    public void saveRow(String batchId, String columnName, String originalValue, String encryptedValue, String data) throws Exception {
        String sql = "INSERT INTO file_tokens (batch_id, column_name, original_value, encrypted_value, data_value, timestamp) VALUES (?,?,?,?,?,NOW())";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, batchId);
            ps.setString(2, columnName);
            ps.setString(3, originalValue);
            ps.setString(4, encryptedValue);
            ps.setString(5, data);
            ps.executeUpdate();
        }
    }
    public void saveToken(String batchId, String columnName, String value, String data, java.util.function.Function<String, String> encryptor) throws Exception {
	    Connection con = DBUtil.getConnection();

	    String sql = "INSERT INTO file_tokens(batch_id, column_name, data_value, encrypted_value, created_at) VALUES(?,?,?,?,NOW())";
	    PreparedStatement ps = con.prepareStatement(sql);

	    ps.setString(1, batchId);
	    ps.setString(2, columnName);  // <-- new column for "Temperature", "Humidity", etc.
	    ps.setString(3, value);
	    ps.setString(4, encryptor.apply(value));

	    ps.executeUpdate();
	    ps.close();
	    con.close();
	}
}
