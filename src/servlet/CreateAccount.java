package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.CreateAccountLogic;
import util.Log4jLogger;

/**
 * Servlet implementation class CreateAccount
 */
@WebServlet("/CreateAccount")
public class CreateAccount extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private  static Log4jLogger logger =  Log4jLogger.getInstance();

    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateAccount() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//JSPを返す
		RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/create_account.jsp");
		// フォワード
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//文字コード設定
		request.setCharacterEncoding("UTF-8");

		String userId = request.getParameter("userName");
		String password = request.getParameter("password");

		//デバック
		System.out.println("CreateAccount UserID:" + userId + "  Password:" + password );

		//処理を行うか決めるFlg
		boolean bStatus = true;

		//ユーザIDがすでに登録されていないか確認する。
		if(!CreateAccountLogic.CheckDuplicateAccount(userId))
		{
			request.setAttribute("failMsg", "入力したユーザーIDはすでに登録されています。");
			bStatus = false;
		}

		//ユーザID登録
		if(!CreateAccountLogic.CreateAccount(userId, password) && bStatus)
		{
			request.setAttribute("failMsg", "ユーザーIDの登録に失敗しました。<br />もう一度実行するか、管理者に問う合わせをお願い致します。");
			bStatus = false;
		}

		RequestDispatcher dispatcher = null;
		if(bStatus)
		{
			//リダイレクト
			dispatcher = request.getRequestDispatcher("/jsp/complete_create_account.jsp");
		}
		else
		{
			dispatcher = request.getRequestDispatcher("/jsp/create_account.jsp");
		}

		//フォワード
		dispatcher.forward(request, response);
	}

}
