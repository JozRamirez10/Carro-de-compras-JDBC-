package webapp.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import webapp.service.LoginService;
import webapp.service.LoginServiceCookieImpl;
import webapp.service.LoginServiceSessionImpl;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Optional;

// https://developer.mozilla.org/es/docs/Web/HTTP/Status -> Status Http

@WebServlet({"/login.html", "/login"})
public class LoginServlet extends HttpServlet {
    final static String USERNAME = "admin";
    final static String PASSWORD = "12345";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        LoginService auth = new LoginServiceSessionImpl();
        Optional<String> usernameOptional = auth.getUsername(req);

        if(usernameOptional.isPresent()){
            resp.setContentType("text/html");
            try (PrintWriter out = resp.getWriter()) {
                out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("     <head>");
                out.println("         <meta charset=\"UTF-8\">");
                out.println("         <title>Hola " + usernameOptional.get() + "</title>");
                out.println("     </head>");
                out.println("     <body>");
                out.println("         <h1>Hola " + usernameOptional.get() + " has iniciado sesión con éxito</h1>");
                out.println("         <p><a href='" + req.getContextPath() + "/index.html'>Volver</a></p>");
                out.println("         <p><a href='" + req.getContextPath() + "/logout'>Cerrar sesión</a></p>");
                out.println("     </body>");
                out.println("</html>");
            }
        }else {
            getServletContext().getRequestDispatcher("/login.jsp").forward(req, resp); // Carga el login.jsp
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        if(USERNAME.equals(username) && PASSWORD.equals(password)){

            // -- Session
            HttpSession session = req.getSession(); // Creación de la session
            session.setAttribute("username", username); // Asignamos un atributo a la session

            resp.sendRedirect(req.getContextPath() + "/login.html");
        }else{
            resp.sendError(HttpServletResponse.SC_UNAUTHORIZED, "No está autorizado para ingresar a esta página");
            // Status 401
        }
    }
}
