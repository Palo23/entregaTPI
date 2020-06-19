package com.bodegas.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bodegas.modelo.*;
import com.bodegas.pack.*;
/**
 * Servlet implementation class InventarioServlet
 */
@WebServlet(name="Inventario", urlPatterns={"/Inventario"})
public class InventarioServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UsuarioConexion userConect;
	private EmpresaConexion empresaConect;
	private InventarioConexion inventarioConect;
       

    public InventarioServlet() {
        this.userConect = new UsuarioConexion();
    	this.empresaConect = new EmpresaConexion();
    	this.inventarioConect = new InventarioConexion();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String action = request.getParameter("action");

		try {
			switch (action) {
			case "show":
				showEmp(request, response);
				break;
			case "all":
				showAllEmp(request, response);
				break;
			case "mine":
				showInv(request, response);
				break;
			case "insert":
				insertProduct(request, response);
				break;
			case "updateCant":
				showEditForm(request, response);
				break;
			case "new":
				showNewForm(request, response);
				break;
			case "updateBod":
				updateUser(request, response);
				break;
			}
		} catch (SQLException ex) {
			throw new ServletException(ex);
		}
		
	}
	
	private void showAllEmp(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		int id = Integer.parseInt(request.getParameter("idEmpresa"));
		List<InventarioModel> listProduct = inventarioConect.selectAllProductos(id);
		request.setAttribute("listProduct", listProduct);
		List<EmpresaModel> listEmpresa = empresaConect.selectAllEmpresa();
		request.setAttribute("listEmpresa", listEmpresa);
		EmpresaModel existingEmpresa = empresaConect.selectEmpresa(id);
		request.setAttribute("nombreEmpresa", existingEmpresa);
		RequestDispatcher dispatcher = request.getRequestDispatcher("inventario.jsp");
		dispatcher.forward(request, response);
	}
	
	private void showEmp(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		List<EmpresaModel> listEmpresa = empresaConect.selectAllEmpresa();
		request.setAttribute("listEmpresa", listEmpresa);
		RequestDispatcher dispatcher = request.getRequestDispatcher("inventario.jsp");
		dispatcher.forward(request, response);
	}
	
	private void showInv(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		int id = Integer.parseInt(request.getParameter("emp"));
		List<InventarioModel> listProduct = inventarioConect.selectAllProductos(id);
		request.setAttribute("listProduct", listProduct);
		EmpresaModel existingEmpresa = empresaConect.selectEmpresa(id);
		request.setAttribute("nombreEmpresa", existingEmpresa);
		RequestDispatcher dispatcher = request.getRequestDispatcher("inventario.jsp");
		dispatcher.forward(request, response);
	}

	private void showNewForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<EmpresaModel> listEmpresa = empresaConect.selectAllEmpresa();
		request.setAttribute("listEmpresa", listEmpresa);
		RequestDispatcher dispatcher = request.getRequestDispatcher("newProduct.jsp");
		dispatcher.forward(request, response);
	}

	private void showEditForm(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		UsuarioModel existingUser = userConect.selectUser(id);
		List<EmpresaModel> listEmpresa = empresaConect.selectAllEmpresa();
		request.setAttribute("listEmpresa", listEmpresa);
		RequestDispatcher dispatcher = request.getRequestDispatcher("newUser.jsp");
		request.setAttribute("user", existingUser);
		dispatcher.forward(request, response);

	}

	private void insertProduct(HttpServletRequest request, HttpServletResponse response) 
			throws SQLException, IOException {
		int idEmpresa = Integer.parseInt(request.getParameter("empresa"));
		int codigo = Integer.parseInt(request.getParameter("codigo"));
		String nombre = request.getParameter("nombre");
		int cantidad = Integer.parseInt(request.getParameter("cantidad"));
		int numero = Integer.parseInt(request.getParameter("bodega"));
		InventarioModel newProduct = new InventarioModel(codigo, idEmpresa, nombre, cantidad, numero);
		inventarioConect.insertProducto(newProduct);
		response.sendRedirect("Inventario?action=show");
	}

	private void updateUser(HttpServletRequest request, HttpServletResponse response) 
			throws SQLException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		String nombre = request.getParameter("nombre");
		String apellido = request.getParameter("apellido");
		String dui = request.getParameter("dui");
		String direccion = request.getParameter("direccion");
		int telefono = Integer.parseInt(request.getParameter("telefono"));
		String username = request.getParameter("username");
		String correo = request.getParameter("correo");
		int idRol = Integer.parseInt(request.getParameter("rol"));
		int idEmpresa = Integer.parseInt(request.getParameter("empresa"));

		UsuarioModel book = new UsuarioModel(id, nombre, apellido, dui, direccion, telefono, username, correo, idRol,  idEmpresa);
		userConect.updateUser(book);
		response.sendRedirect("Usuario?action=list");
	}

	/*private void deleteUser(HttpServletRequest request, HttpServletResponse response) 
			throws SQLException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		userConect.deleteUser(id);
		response.sendRedirect("Usuario?action=list");

	}*/

	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}