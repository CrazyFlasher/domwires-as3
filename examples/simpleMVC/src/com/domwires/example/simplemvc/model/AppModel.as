/**
 * Created by CrazyFlasher on 1.12.2016.
 */
package com.domwires.example.simplemvc.model
{
	import com.domwires.core.mvc.model.AbstractModel;

	public class AppModel extends AbstractModel implements IAppModel
	{
		private var _firstName:String;
		private var _lastName:String;
		private var _age:int;
<<<<<<< HEAD
		private var _country:int;
=======
>>>>>>> 06cb5a62b2360c973453b9b79d2eba0c61d11bec

		public function setFirstName(value:String):IAppModel
		{
			_firstName = value;

			dispatchMessage(AppModelMessage.FIRST_NAME_CHANGED, null, true);

			return this;
		}

		public function setLastName(value:String):IAppModel
		{
			_lastName = value;

			dispatchMessage(AppModelMessage.LAST_NAME_CHANGED, null, true);

			return this;
		}

		public function setAge(value:int):IAppModel
		{
			_age = value;

			dispatchMessage(AppModelMessage.AGE_CHANGED, null, true);

			return this;
		}
<<<<<<< HEAD
		
		public function setCountry(value:int):IAppModel
		{
			_country = value;

			dispatchMessage(AppModelMessage.COUNTRY_CHANGED, null, true);

			return this;
		}
=======
>>>>>>> 06cb5a62b2360c973453b9b79d2eba0c61d11bec

		public function get firstName():String
		{
			return _firstName;
		}

		public function get lastName():String
		{
			return _lastName;
		}

		public function get age():int
		{
			return _age;
		}
<<<<<<< HEAD
		
		public function get country():int
		{
			return _country;
		}
=======
>>>>>>> 06cb5a62b2360c973453b9b79d2eba0c61d11bec
	}
}
