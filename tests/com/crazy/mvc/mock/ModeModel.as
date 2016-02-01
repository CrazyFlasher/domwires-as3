/**
 * Created by Anton Nefjodov on 1.02.2016.
 */
package com.crazy.mvc.mock
{
	import com.crazy.mvc.model.Model;

	public class ModeModel extends Model
	{
		public function ModeModel()
		{
			super();
		}

		public function get message():String
		{
			return "Message from MockModel";
		}
	}
}
