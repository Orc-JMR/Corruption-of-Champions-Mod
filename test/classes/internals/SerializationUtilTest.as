package classes.internals
{
	import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	import org.hamcrest.collection.*;
	
	import classes.internals.ISerializable;
	import classes.internals.ISerializableAMF;
	
	public class SerializationUtilTest
	{
		private static const TEST_INSTANCES:int = 5;
		
		private var testObject:Array;
		private var testVector:Vector.<ISerializable>;
		private var testAMFVector:Vector.<ISerializableAMF>;
		private var deserializedVector:Vector.<*>;
		private var testArray:Array;
		private var deserializedArray:Array;
		
		private function getTestObject():* {
			return SerializationUtils.serializeVector(testVector as Vector.<*>);
		}
		
		[Before]
		public function setUp():void
		{
			testObject = null;
			testVector = new Vector.<ISerializable>();
			testAMFVector = new Vector.<ISerializableAMF>();
			deserializedVector = new Vector.<*>();
			testArray = [];
			deserializedArray = [];
			for (var i:int = 0; i < TEST_INSTANCES; i++) {
				testVector.push(new SerializationDummy(i, i + 1));
				testAMFVector.push(new AMFSerializationDummy(i, i + 1));
				testArray.push(new SerializationDummy(i, i + 1));
			}
		}
		
		[Test]
		public function serializeVectorObjectSize():void
		{
			testObject = getTestObject();
			
			assertThat(testObject, arrayWithSize(TEST_INSTANCES));
		}
		
		[Test]
		public function serializeVectorLastObjectValue():void
		{
			testObject = getTestObject();
			
			assertThat(testObject[TEST_INSTANCES - 1], hasProperties({foo: TEST_INSTANCES - 1, bar: TEST_INSTANCES}));
		}
		
		[Test]
		public function serializeVectorWithAMFObjectSize():void
		{
			testObject = SerializationUtils.serializeVectorWithAMF(testAMFVector);
			
			assertThat(testObject, arrayWithSize(TEST_INSTANCES));
		}
		
		[Test]
		public function serializeVectorWithAMFLastObjectValue():void
		{
			testObject = SerializationUtils.serializeVectorWithAMF(testAMFVector);
			
			assertThat(testObject[TEST_INSTANCES - 1], instanceOf(AMFSerializationDummy));
		}
		
		[Test]
		public function deserializeVectorSize():void {
			testObject = getTestObject();
			
			SerializationUtils.deserializeVector(deserializedVector, testObject, SerializationDummy);
			
			assertThat(deserializedVector, arrayWithSize(TEST_INSTANCES));
		}
		
		[Test]
		public function deserializeVectorType():void {
			testObject = getTestObject();
			
			SerializationUtils.deserializeVector(deserializedVector,testObject, SerializationDummy);
			
			assertThat(deserializedVector[TEST_INSTANCES - 1], instanceOf(SerializationDummy));
		}
		
		[Test]
		public function deserializeVectorLastElementProperties():void {
			testObject = getTestObject();
			
			SerializationUtils.deserializeVector(deserializedVector, testObject, SerializationDummy);
			
			assertThat(deserializedVector[TEST_INSTANCES - 1], hasProperties({foo: TEST_INSTANCES - 1}));
			assertThat((deserializedVector[TEST_INSTANCES - 1] as SerializationDummy).getBar(), equalTo(TEST_INSTANCES));
		}
		
		[Test(expected="ArgumentError")]
		public function deserializeWithNonSerializableType():void {
			SerializationUtils.deserializeVector(new Vector.<*>(), new Array(), String);
		}
				
		[Test(expected="ArgumentError")]
		public function deserializeWithNullDestination():void {
			SerializationUtils.deserializeVector(null, new Array(), SerializationDummy);
		}
		
		[Test(expected="ArgumentError")]
		public function deserializeWithNullSource():void {
			SerializationUtils.deserializeVector(new Vector.<*>(), null, SerializationDummy);
		}
		
		[Test]
		public function castVectorCheckProperties():void {
			var destinationVector:Vector.<SerializationDummy> = new Vector.<SerializationDummy>();
			
			SerializationUtils.castVector(destinationVector, testVector, SerializationDummy);
			
			assertThat(destinationVector[TEST_INSTANCES - 1], hasProperties({foo: TEST_INSTANCES - 1}));
			assertThat(destinationVector[TEST_INSTANCES - 1].getBar(), equalTo(TEST_INSTANCES));
		}
		
		[Test]
		public function castVectorCheckType():void {
			var destinationVector:Vector.<SerializationDummy> = new Vector.<SerializationDummy>();
			
			SerializationUtils.castVector(destinationVector, testVector, SerializationDummy);
			
			assertThat(destinationVector[TEST_INSTANCES - 1], instanceOf(SerializationDummy));
		}
		
		[Test(expected="ArgumentError")]
		public function deserializeWithNonSerializableAMFType():void {
			SerializationUtils.deserializeVectorWithAMF(new Array(), String);
		}
		
		private function deserializeAMF():Vector.<ISerializableAMF> {
			testObject = SerializationUtils.serializeVectorWithAMF(testAMFVector);
			return SerializationUtils.deserializeVectorWithAMF(testObject, AMFSerializationDummy);
		}
		
		[Test]
		public function deserializeVectorWithAMFSize():void {
			var vector:Vector.<ISerializableAMF> = deserializeAMF();
			
			assertThat(vector, arrayWithSize(TEST_INSTANCES));
		}
		
		[Test]
		public function deserializeVectorWithAMFType():void {
			var vector:Vector.<ISerializableAMF> = deserializeAMF();
			
			assertThat(vector[TEST_INSTANCES - 1], instanceOf(ISerializableAMF));
		}
		
		[Test]
		public function deserializeVectorWithAMFProperty():void {
			var vector:Vector.<ISerializableAMF> = deserializeAMF();
			
			assertThat(vector[TEST_INSTANCES - 1], hasProperties({foo: TEST_INSTANCES - 1, bar: TEST_INSTANCES}));
		}

		[Test]
		public function serializeArrayObjectSize():void
		{
			testObject = getTestObject();
			
			assertThat(testObject, arrayWithSize(TEST_INSTANCES));
		}
		
		[Test]
		public function serializeArrayLastObjectValue():void
		{
			testObject = getTestObject();
			
			assertThat(testObject[TEST_INSTANCES - 1], hasProperties({foo: TEST_INSTANCES - 1, bar: TEST_INSTANCES}));
		}
		
		[Test]
		public function deserializeArraySize():void {
			testObject = getTestObject();
			
			SerializationUtils.deserializeArray(deserializedArray, testObject, SerializationDummy);
			
			assertThat(deserializedArray, arrayWithSize(TEST_INSTANCES));
		}
		
		[Test]
		public function deserializeArrayType():void {
			testObject = getTestObject();
			
			SerializationUtils.deserializeArray(deserializedArray,testObject, SerializationDummy);
			
			assertThat(deserializedArray[TEST_INSTANCES - 1], instanceOf(SerializationDummy));
		}
		
		[Test]
		public function deserializeArrayLastElementProperties():void {
			testObject = getTestObject();
			
			SerializationUtils.deserializeArray(deserializedArray, testObject, SerializationDummy);
			
			assertThat(deserializedArray[TEST_INSTANCES - 1], hasProperties({foo: TEST_INSTANCES - 1}));
			assertThat((deserializedArray[TEST_INSTANCES - 1] as SerializationDummy).getBar(), equalTo(TEST_INSTANCES));
		}
		
		[Test(expected="ArgumentError")]
		public function deserializeArrayWithNonSerializableType():void {
			SerializationUtils.deserializeArray([], [], String);
		}
				
		[Test(expected="ArgumentError")]
		public function deserializeArrayWithNullDestination():void {
			SerializationUtils.deserializeArray(null, [], SerializationDummy);
		}
		
		[Test(expected="ArgumentError")]
		public function deserializeArrayWithNullSource():void {
			SerializationUtils.deserializeArray([], null, SerializationDummy);
		}
	}
}

import classes.internals.ISerializable;
import classes.internals.ISerializableAMF;
import flash.errors.IllegalOperationError;

class SerializationDummy implements ISerializable
{
	public var foo:int;
	private var bar:int;
	
	public function SerializationDummy(foo:int = -1, bar:int = -1)
	{
		this.foo = foo;
		this.bar = bar;
	}
	
	public function getBar():int {
		return this.bar;
	}
	
	public function serialize(relativeRootObject:*):void
	{
		relativeRootObject.foo = foo;
		relativeRootObject.bar = bar;
	}
	
	public function deserialize(relativeRootObject:*):void
	{
		this.foo = relativeRootObject.foo;
		this.bar = relativeRootObject.bar;
	}
}

class AMFSerializationDummy implements ISerializableAMF
{
	public var foo:int;
	public var bar:int;
	
	public function AMFSerializationDummy(foo:int = -2, bar:int = -2)
	{
		this.foo = foo;
		this.bar = bar;
	}
}
