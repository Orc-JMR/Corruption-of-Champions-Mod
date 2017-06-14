/**
 * Created by aimozg on 25.04.2017.
 */
package classes.internals {
public class SimpleSerializable extends Utils implements ISerializable {
	protected const myPublicPrimitives: Array    = [];
	protected const myPublicSerializables: Array = [];
	/**
	 * @see Utils.copyObject
	 * @param names names of !public! !primitive!-typed properties that should be saved/loaded
	 */
	protected function addPublicPrimitives(names:Array): void {
		myPublicPrimitives.push.apply(myPublicPrimitives,names);
	}
	protected function addPublicPrimitive(fieldName:String, jsonName:String, defaultValueOrFn:* = undefined):void {
		myPublicPrimitives.push({skey:fieldName,dkey:jsonName,'default':defaultValueOrFn});
	}
	/**
	 * @param names names of !public! !ISerializable!-typed properties that should be saved/loaded
	 */
	protected function addPublicSerializables(names:Array):void {
		myPublicSerializables.push.apply(myPublicSerializables,names);
	}
	public function saveToObject(o:Object = null):Object {
		if (!o) o = {};
		if (myPublicPrimitives.length > 0) o = copyObjectEx(o, this, myPublicPrimitives, true);
		for each (var key:String in myPublicSerializables) {
			var ok:* = {};
			(this[key] as ISerializable).serialize(ok);
			o[key] = ok;
		}
		return o;
	}
	public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		if (!(o is Object) || o === null) o = {};
		if (myPublicPrimitives.length>0) copyObjectEx(this, o, myPublicPrimitives, false, ignoreErrors);
		for each (var key:String in myPublicSerializables) {
			var v:* = o[key];
			if (!(v is Object) || v === null) v = {};
			try {
				(this[key] as ISerializable).deserialize(v);
			} catch (e:*) {
				if (!ignoreErrors) throw e;
				trace(e);
			}
		}
	}
	public static function getPublicPrimitives(o:SimpleSerializable):Array {
		return o.myPublicPrimitives;
	}
	public static function getPublicSerializables(o:SimpleSerializable):Array {
		return o.myPublicSerializables;
	}

	public function serialize(relativeRootObject:*):void {
		saveToObject(relativeRootObject);
	}
	public function deserialize(relativeRootObject:*):void {
		loadFromObject(relativeRootObject, true);
	}
}
}
