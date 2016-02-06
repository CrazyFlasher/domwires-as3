/**
 * Created by Anton Nefjodov on 6.02.2016.
 */
package com.crazyfm.extension.preloader
{
	public class LoadingProgressVo
	{
		private var _bytesLoaded:Number;
		private var _bytesTotal:Number;

		public function LoadingProgressVo()
		{
		}

		public function get bytesLoaded():Number
		{
			return _bytesLoaded;
		}

		public function set bytesLoaded(value:Number):void
		{
			_bytesLoaded = value;
		}

		public function get bytesTotal():Number
		{
			return _bytesTotal;
		}

		public function set bytesTotal(value:Number):void
		{
			_bytesTotal = value;
		}
	}
}
