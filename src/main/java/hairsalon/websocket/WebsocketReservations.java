package hairsalon.websocket;

import java.util.ArrayList;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

class Tempws {
	WebSocketSession webSocketSession;
	String name;
}

public class WebsocketReservations extends TextWebSocketHandler {
	
	private ArrayList<WebSocketSession> list = new ArrayList<>();
	
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		Tempws tempws = new Tempws();
		tempws.webSocketSession = session;
		tempws.name = (String) session.getAttributes().get("user");
		
		list.add(session);
	}
	
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		list.remove(session);
	}
	
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		TextMessage msg = new TextMessage("");
		
		for(WebSocketSession one : list) {
			one.sendMessage(msg);
		}
	}
}