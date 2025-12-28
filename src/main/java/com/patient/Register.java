package com.patient;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;

import com.dao.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/Register")
public class Register extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String firstName = request.getParameter("first_name");
		String lastName = request.getParameter("last_name");
		String gender = request.getParameter("gender");
		int age = Integer.parseInt(request.getParameter("age"));
		String bloodGroup = request.getParameter("blood_group");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String address = request.getParameter("address");
		String disease = request.getParameter("disease");
		String doctorName = request.getParameter("doctor_name");
		String admissionDate = request.getParameter("admission_date");
		String dischargeDate = request.getParameter("discharge_date");
		int roomNumber = Integer.parseInt(request.getParameter("room_number"));
		double billAmount = Double.parseDouble(request.getParameter("bill_amount"));

		try {
			Connection con = DBConnection.getConnection();

			String sql = "INSERT INTO patient (first_name,last_name,gender, age, blood_group, phone, email, address, disease, doctor_name, admission_date, discharge_date, room_number, bill_amount) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";

			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, firstName);
			ps.setString(2, lastName);
			ps.setString(3, gender);
			ps.setInt(4, age);
			ps.setString(5, bloodGroup);
			ps.setString(6, phone);
			ps.setString(7, email);
			ps.setString(8, address);
			ps.setString(9, disease);
			ps.setString(10, doctorName);
			ps.setDate(11, Date.valueOf(admissionDate));
			ps.setDate(12, Date.valueOf(dischargeDate));
			ps.setInt(13, roomNumber);
			ps.setDouble(14, billAmount);

			int result = ps.executeUpdate();

			if (result > 0) {
				request.getRequestDispatcher("/Patient/success.jsp").forward(request, response);
			} else {
				request.getRequestDispatcher("/Patient/error.jsp").forward(request, response);
			}

			ps.close();
			con.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
}
