package servlet;

import static constants.WeightDataConst.*;

import java.util.Date;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;

import util.ObjectUtil;
import model.MainLogic;
import model.User;

/**
 * Servlet implementation class Main
 */
@WebServlet("/Main")
public class Main extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Main() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// ログイン済みか確認
		HttpSession session = request.getSession();
		User userData = (User) session.getAttribute("user");
		if (userData == null) {
			// 未ログインのため、ログイン画面へ遷移
			response.sendRedirect("/Weighter");
		} else {
			// 今日の体重取得
			Double todayWeight = MainLogic.GetTodayWeight(userData.getId());
			// 今日の体重が登録されているか
			if (todayWeight == NOTHING_WEIGHT)
			{
				request.setAttribute("todayWeight", "登録されていません");
				request.setAttribute("registFlg", 0);
			}
			else
			{
				request.setAttribute("todayWeight", todayWeight.toString() + "Kg");
				request.setAttribute("registFlg", 1);
			}

			// 過去30日分の体重データを表示する。
			request.setAttribute("past30Days", MainLogic.CreatePast30DaysWeightData(userData.getId()));


			RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/main.jsp");
			// フォワード
			dispatcher.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//文字コード設定
		request.setCharacterEncoding("UTF-8");

		// ユーザーID
		HttpSession session = request.getSession();
		String id = ((User) session.getAttribute("user")).getId();

		// コメント
		StringBuilder comment = new StringBuilder();
		comment.append("");

		//上書きフラグ
		int registFlg = 0;
		String strRegistFlg = request.getParameter("registFlg");
		if(strRegistFlg != null && !(strRegistFlg.isEmpty()))
			if(strRegistFlg.equals("1"))
				registFlg = 1;

		try {
			// 体重
			Double weight = ObjectUtil.toDouble(request.getParameter("weight"));

			// 今日の体重データを登録
			if (!MainLogic.ProcGateWeightData(id, new Date(), weight, comment, registFlg)) {
				request.setAttribute("failMsg", "体重データの登録に失敗しました。もう一度やり直してください。");
			}

		} catch (NullPointerException e) {
			request.setAttribute("failMsg", e.getMessage());
		} catch (NumberFormatException e) {
			request.setAttribute("failMsg", "登録できない値が入力されています。もう一度やり直してください。");
		}

		// 今日の体重取得
		Double todayWeight = MainLogic.GetTodayWeight(id);
		// 今日の体重が登録されているか
		if (todayWeight == NOTHING_WEIGHT)
		{
			request.setAttribute("todayWeight", "登録されていません");
			request.setAttribute("registFlg", 0);
		}
		else
		{
			request.setAttribute("todayWeight", todayWeight.toString() + "Kg");
			request.setAttribute("registFlg", 1);
		}

		// 過去30日分の体重データを表示する。
		request.setAttribute("past30Days", MainLogic.CreatePast30DaysWeightData(id));

		RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/main.jsp");
		// フォワード
		dispatcher.forward(request, response);
	}

}
