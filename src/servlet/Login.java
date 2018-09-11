package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;

import model.LoginLogic;
import model.User;
import util.Log4jLogger;
/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private  static Log4jLogger logger =  Log4jLogger.getInstance();

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// ログイン画面へ
		RequestDispatcher dispatcher = null;
		dispatcher = request.getRequestDispatcher("jsp/index.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//リクエストパラメータ取得
		request.setCharacterEncoding("UTF-8");
		String userName = request.getParameter("userName");
		String password = request.getParameter("password");

		RequestDispatcher dispatcher = null;

			User user = LoginLogic.Login(userName, password);

			//Userデータが帰ってきているか確認
			if(user == null)
			{
				logger.InfoLog("Login Failed User:" + userName);
				request.setAttribute("failMsg", "ユーザ名、またはパスワードが間違っています。");
				dispatcher = request.getRequestDispatcher("jsp/index.jsp");
				//フォワード
				dispatcher.forward(request, response);
			}
			else
			{
				logger.InfoLog("Login Success User:" + userName);
				HttpSession session = request.getSession();
				session.setAttribute("user", user);
				//リダイレクト
				response.sendRedirect("/Weighter/Main");
			}
	}

}
