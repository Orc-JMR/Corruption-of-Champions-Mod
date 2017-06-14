package classes
{
import classes.internals.SimpleSerializable;

public class KeyItemClass extends SimpleSerializable
	{
		//constructor
		public function KeyItemClass()
		{
			addPublicPrimitives(["keyName","value1","value2","value3","value4"]);
		}
		
		//data
		public var keyName:String = "";
		//v1-v4 for storing extra stuff.
		public var value1:Number = 0;
		public var value2:Number = 0;
		public var value3:Number = 0;
		public var value4:Number = 0;
	}
}