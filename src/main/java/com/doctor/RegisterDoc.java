package com.doctor;

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

@WebServlet("/RegisterDoc")
public class RegisterDoc extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String firstName = request.getParameter("first_name");
		String lastName = request.getParameter("last_name");
		String gender = request.getParameter("gender");
		String specialization = request.getParameter("specialization");
		String qualification = request.getParameter("qualification");
		int experience = Integer.parseInt(request.getParameter("experience"));
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String department = request.getParameter("department");
		int roomNumber = Integer.parseInt(request.getParameter("room_number"));
		String joiningDate = request.getParameter("joining_date");
		double salary = Double.parseDouble(request.getParameter("salary"));

		try {
			Connection con = DBConnection.getConnection();

			String sql = "INSERT INTO doctor "
					+ "(first_name, last_name, gender, specialization, qualification, experience, phone, email, department, room_number, joining_date, salary) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, firstName);
			ps.setString(2, lastName);
			ps.setString(3, gender);
			ps.setString(4, specialization);
			ps.setString(5, qualification);
			ps.setInt(6, experience);
			ps.setString(7, phone);
			ps.setString(8, email);
			ps.setString(9, department);
			ps.setInt(10, roomNumber);
			ps.setDate(11, Date.valueOf(joiningDate));
			ps.setDouble(12, salary);

			int result = ps.executeUpdate();

			if (result > 0) {
				request.getRequestDispatcher("/Doctor/success.jsp").forward(request, response);
			} else {
				request.getRequestDispatcher("/Doctor/error.jsp").forward(request, response);
			}

			ps.close();
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
