/**
 * Created by CrazyFlasher on 1.12.2016.
 */
package com.domwires.example.simplemvc.view
{
	import com.domwires.core.mvc.message.IMessage;
	import com.domwires.core.mvc.view.AbstractView;
	import com.domwires.example.simplemvc.model.AppModelMessage;
	import com.domwires.example.simplemvc.model.IAppModelImmutable;

	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import feathers.themes.MetalWorksMobileTheme;

	import starling.display.DisplayObjectContainer;
	import starling.events.Event;

	public class AppView extends AbstractView
	{
		[Autowired]
		public var viewContainer:DisplayObjectContainer;

		[Autowired]
		public var model:IAppModelImmutable;

		private var firstNameLabel:Label;
		private var lastNameLabel:Label;
		private var ageLabel:Label;
		private var countryLabel:Label;

		[PostConstruct]
		public function init():void
		{
			new MetalWorksMobileTheme();

			var layoutGroup:LayoutGroup = new LayoutGroup();
			layoutGroup.layout = new VerticalLayout();
			layoutGroup.y = 50;

			firstNameLabel = createForm("First name:", layoutGroup, onFirstNameClicked);
			lastNameLabel = createForm("Last name:", layoutGroup, onLastNameClicked);
			ageLabel = createForm("Age:", layoutGroup, onAgeClicked);
			countryLabel = createForm("Country:", layoutGroup, onCountryClicked);

			viewContainer.addChild(layoutGroup);

			addMessageListener(AppModelMessage.FIRST_NAME_CHANGED, firstNameChanged);
			addMessageListener(AppModelMessage.LAST_NAME_CHANGED, lastNameChanged);
			addMessageListener(AppModelMessage.AGE_CHANGED, ageNameChanged);
			addMessageListener(AppModelMessage.COUNTRY_CHANGED, CountryNameChanged);

		}

		private function ageNameChanged(m:IMessage):void
		{
			ageLabel.text = model.age.toString();
		}

		private function lastNameChanged(m:IMessage):void
		{
			lastNameLabel.text = model.lastName;
		}

		private function firstNameChanged(m:IMessage):void
		{
			firstNameLabel.text = model.firstName;
		}
		
		private function CountryNameChanged(m:IMessage):void
		{
			countryLabel.text = model.country.toString();
		}

		private function createForm(label:String, group:LayoutGroup, onClick:Function):Label
		{
			var layoutGroup:LayoutGroup = new LayoutGroup();
			var hLayout:HorizontalLayout = new HorizontalLayout();
			hLayout.gap = 5;
			layoutGroup.layout = hLayout;

			var idLabel:Label = new Label();
			idLabel.width = 100;
			idLabel.text = label;

			var button:Button = new Button();
			button.label = "Generate";

			var resultLabel:Label = new Label();

			layoutGroup.addChild(idLabel);
			layoutGroup.addChild(button);
			layoutGroup.addChild(resultLabel);

			group.addChild(layoutGroup);

			button.addEventListener(Event.TRIGGERED, onClick);

			return resultLabel;
		}

		private function onFirstNameClicked():void
		{
			dispatchMessage(AppViewMessage.FIRST_NAME_CLICKED, null, true);
		}

		private function onLastNameClicked():void
		{
			dispatchMessage(AppViewMessage.LAST_NAME_CLICKED, null, true);
		}

		private function onAgeClicked():void
		{
			dispatchMessage(AppViewMessage.AGE_CLICKED, null, true);
		}
		
		private function onCountryClicked():void
		{
			dispatchMessage(AppViewMessage.COUNTRY_CLICKED, null, true);
		}
	}
}
