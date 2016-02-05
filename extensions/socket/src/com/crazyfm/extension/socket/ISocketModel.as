/**
 * Created by Anton Nefjodov on 5.02.2016.
 */
package com.crazyfm.extension.socket
{
	/**
	 * Connects, sends and receives data from socket server.
	 */
	public interface ISocketModel extends IModel
	{
		/**
		 * Tries to connect to socket server.
		 * @param ip
		 * @param port
		 */
		function connect(ip:String, port:int):void;

		/**
		 * Disconnects from socket server.
		 */
		function disconnect():void;

		/**
		 * Sends request to socket server.
		 * @param request
		 */
		function sendRequest(request:ISocketRequestDto):void;

		/**
		 * Sets socket timeout.
		 * @param value
		 */
		function set timeout(value:int):void;

		/**
		 * Returns true, if connected to socket server.
		 */
		function get isConnected():Boolean;
	}
}
