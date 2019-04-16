package Dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import Bean.Place;

public class PlaceDao {
	public PlaceDao(){
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public Connection getConnection() throws SQLException{
		return DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/head"
				+ "?characterEncoding=UTF-8","root","admin");
		
	}
	public List<Place> list(){
		List<Place> l = new ArrayList<Place>();
		String sql = "select * from place order by id ";
		try(Connection c = getConnection();
				Statement s = c.createStatement();){
			ResultSet rs = s.executeQuery(sql);
			while(rs.next()){
				Place h = new Place();
				h.setId(rs.getInt(1));
				h.setName(rs.getString(2));
				h.setNum(rs.getInt(3));
				h.setX(rs.getInt(4));
				h.setY(rs.getInt(5));
				l.add(h);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return l;
	}
	public Place get(int i){
		Place h = null;
		try(Connection c = getConnection();
				Statement s = c.createStatement();){
			String sql="select *from place where id = "+i;
			ResultSet rs = s.executeQuery(sql);
			while(rs.next()){
				h = new Place();
				h.setId(rs.getInt(1));
				h.setName(rs.getString(2));
				h.setNum(rs.getInt(3));
				h.setX(rs.getInt(4));
				h.setY(rs.getInt(5));
			}
			s.execute(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return h;
	}
}
