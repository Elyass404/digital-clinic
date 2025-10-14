package com.clinicdigital.controller;

import com.clinicdigital.model.Room;
import com.clinicdigital.repository.RoomRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/rooms")
public class RoomServlet extends HttpServlet {

    private final RoomRepository repo = new RoomRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            // List all rooms
            List<Room> rooms = repo.findAll();
            request.setAttribute("rooms", rooms);
            request.getRequestDispatcher("/WEB-INF/views/rooms.jsp").forward(request, response);

        } else if (action.equals("edit")) {
            // Show edit form
            Long id = Long.parseLong(request.getParameter("id"));
            Room room = repo.findById(id);
            request.setAttribute("room", room);
            request.getRequestDispatcher("/WEB-INF/views/edit_room.jsp").forward(request, response);

        } else if (action.equals("delete")) {
            // Delete room
            Long id = Long.parseLong(request.getParameter("id"));
            repo.delete(id);
            response.sendRedirect(request.getContextPath() + "/rooms");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null || action.equals("create")) {
            // Create new room
            String name = request.getParameter("name");
            int capacity = Integer.parseInt(request.getParameter("capacity"));

            if (name != null && !name.trim().isEmpty()) {
                Room room = new Room(name.trim(), capacity);
                repo.save(room);
            }

            response.sendRedirect(request.getContextPath() + "/rooms");

        } else if (action.equals("update")) {
            // Update existing room
            Long id = Long.parseLong(request.getParameter("id"));
            String name = request.getParameter("name");
            int capacity = Integer.parseInt(request.getParameter("capacity"));

            Room room = repo.findById(id);
            if (room != null && name != null && !name.trim().isEmpty()) {
                room.setName(name.trim());
                room.setCapacity(capacity);
                repo.update(room);
            }

            response.sendRedirect(request.getContextPath() + "/rooms");
        }
    }
}
