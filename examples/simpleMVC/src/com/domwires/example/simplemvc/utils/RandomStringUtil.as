/**
 * Created by CrazyFlasher on 1.12.2016.
 */
package com.domwires.example.simplemvc.utils
{
	public class RandomStringUtil
	{
		public static function get randomString():String
		{
			var chars:String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
			var numChars:Number = chars.length - 1;
			var randomChar:String = "";

			for (var i:Number = 0; i < 10; i++)
			{
				randomChar += chars.charAt(Math.floor(Math.random() * numChars));
			}
			
			return randomChar;
		}
	}
}
