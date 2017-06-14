package classes.internals 
{
	import classes.Items.Armors.Nothing;
	import flash.errors.IllegalOperationError;
	/**
	 * A class providing utility methods to make serialization and deserialization easier.
	 */
	public class SerializationUtils 
	{
		public function SerializationUtils() 
		{
			throw new IllegalOperationError("This class cannot be instantiated");
		}
		
		/**
		 * Serializes a Vector into an array.
		 * @param	vector to serialize
		 * @return a array containing the serialized vector
		 */
		public static function serializeVector(vector:Vector.<*>):Array {
			var serialized:Array = [];
			
			for each(var element:ISerializable in vector) {
				var obj:Array = [];
				serialized.push(obj);
				
				element.serialize(obj);
			}
			
			return serialized;
		}
		
		/**
		 * Deserializes a Array into a Vector of Serializable
		 * @param   destinationVector Vector where deserialized items will be written
		 * @param	serializedVector an Array containing the serialized vector
		 * @param	type of the serialized Vector
		 * @return a deserialized Vector
		 */
		public static function deserializeVector(destinationVector:Vector.<*>, serializedVector:Array, type:Class):Vector.<*> {
			// 'is' will only work on an instance
			if (!(new type() is ISerializable)) {
				throw new ArgumentError("Type must implement Serializable");
			}

			if (destinationVector === null) {
				throw new ArgumentError("Destination Vector cannot be null");
			}

			if (serializedVector === null) {
				throw new ArgumentError("Serialized Vector cannot be null");
			}
			
			for each(var element:Object in serializedVector) {
				var instance:ISerializable = new type();
				instance.deserialize(element);
				destinationVector.push(instance);
			}
			return destinationVector;
		}

		/**
		 * Deserializes a Array of Serializables
		 * @param   dst an Array where deserialized items will be written
		 * @param	src an Array containing the serialized array
		 * @param	type of the serialized Array
		 * @return dst
		 */
		public static function deserializeArray(dst:Array, src:Array, type:Class):Array {
			// 'is' will only work on an instance
			if (!(new type() is ISerializable)) {
				throw new ArgumentError("Type must implement Serializable");
			}

			deserializeArrayEx(dst, src, {
				factory: function ():Object {
					return new type();
				}
			});
			return dst;
		}

		/**
		 * Deserializes a Array of ISerializable
		 * @param   dst an Array where deserialized items will be written
		 * @param	src an Array containing the serialized array
		 * @param	options.factory (mandatory) `Class` or `function ()=>Object` creating new instance of the object
		 * @param	options.filter (optional) `function (T)=>Boolean` to post-process and check object.
		 * @return dst
		 */
		public static function deserializeArrayEx(dst:Array, src:Array, options:Object):Array {
			if (dst === null) {
				throw new ArgumentError("Destination Vector cannot be null");
			}
			if (src === null) {
				throw new ArgumentError("Serialized Vector cannot be null");
			}
			var factory:* = options.factory;
			var factoryFn:Function;
			if (factory is Class) {
				factoryFn = function ():Object {
					//noinspection JSPotentiallyInvalidConstructorUsage
					return new factory();
				}
			} else {
				factoryFn = factory as Function;
				if  (factoryFn == null) throw new ArgumentError("Invalid options.factory");
			}

			var filter:Function = options.filter as Function;
			for (var i:int=0,n:int=src.length;i<n;i++) {
				var instance:ISerializable = factoryFn();
				instance.deserialize(src[i]);
				if (filter != null && !filter(instance)) continue;
				dst.push(instance);
			}
			return dst;
		}
		
		
		/**
		 * Serializes a Vector into an array using AMF.
		 * @param	vector to serialize
		 * @return a array containing the serialized vector
		 */
		public static function serializeVectorWithAMF(vector:Vector.<ISerializableAMF>):Array {
			var serialized:Array = [];
			
			for each(var element:ISerializableAMF in vector) {
				serialized.push(element);
			}
			
			return serialized;
		}
		
		/**
		 * Deserializes a Array into a Vector using AMF
		 * @param	serializedVector an Array containing the serialized vector
		 * @param	type of the serialized Vector
		 * @return a deserialized Vector
		 */
		public static function deserializeVectorWithAMF(serializedVector:Array, type:Class):Vector.<ISerializableAMF> {
			// 'is' will only work on an instance
			if (!(new type() is ISerializableAMF)) {
				throw new ArgumentError("Type must implement SerializableAMF");
			}
			
			var deserialized:Vector.<ISerializableAMF> = new Vector.<ISerializableAMF>();
			
			for each(var element:Object in serializedVector) {
				deserialized.push(element as type);
			}
			
			return deserialized;
		}
		
		/**
		 * Casts a vector from one type to another. DOES NO VALIDATION.
		 * @param	destinationVector vector where casted elements will be put
		 * @param	sourceVector where elements for casting will be read from
		 * @param	destinationType the class to cast to
		 */
		public static function castVector(destinationVector:*, sourceVector:*, destinationType:Class):void {
			/**
			 * If anyone has a better idea, i'm all ears.
			 * Implement your solution and see if the tests pass.
			 */
			
			for each(var element:* in sourceVector) {
				destinationVector.push(element as destinationType);
			}
		}
	}
}
