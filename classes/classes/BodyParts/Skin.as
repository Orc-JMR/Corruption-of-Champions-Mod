package classes.BodyParts 
{
	import classes.Appearance;
	import classes.internals.SimpleJsonable;

	/**
	 * Container class for the players skin
	 * @since December 27, 2016
	 * @author Stadler76
	 */
	public class Skin extends SaveableBodyPart
	{
		include "../../../includes/appearanceDefs.as";

		public var type:Number = SKIN_TYPE_PLAIN;
		public var tone:String = "albino";
		public var desc:String = "skin";
		public var adj:String = "";
		public var furColor:String = "no";

		public function Skin() {
			super("skin",["type","tone","desc","adj","furColor"]);
		}

		public function skinFurScales():String
		{
			var skinzilla:String = "";
			//Adjectives first!
			if (adj != "")
				skinzilla += adj + ", ";

			//Fur handled a little differently since it uses haircolor
			skinzilla += isFluffy() ? furColor : tone;

			return skinzilla + " " + desc;
		}

		public function description(noAdj:Boolean = false, noTone:Boolean = false):String
		{
			var skinzilla:String = "";

			//Adjectives first!
			if (!noAdj && adj != "" && !noTone && tone != "rough gray")
				skinzilla += adj + ", ";
			if (!noTone)
				skinzilla += tone + " ";

			//Fur handled a little differently since it uses haircolor
			skinzilla += isFluffy() ? "skin" : desc;

			return skinzilla;
		}

		public function hasFur():Boolean
		{
			return type == SKIN_TYPE_FUR;
		}

		public function hasWool():Boolean
		{
			return type == SKIN_TYPE_WOOL;
		}

		public function hasFeathers():Boolean
		{
			return  type == SKIN_TYPE_FEATHERED;
		}

		public function isFurry():Boolean
		{
			return [SKIN_TYPE_FUR, SKIN_TYPE_WOOL].indexOf(type) != -1;
		}

		public function isFluffy():Boolean
		{
			return [SKIN_TYPE_FUR, SKIN_TYPE_WOOL, SKIN_TYPE_FEATHERED].indexOf(type) != -1;
		}

		override public function restore(keepTone:Boolean = true):void
		{
			type = SKIN_TYPE_PLAIN;
			if (!keepTone) tone = "albino";
			desc = "skin";
			adj  = "";
			furColor = "no";
		}

		public function setProps(p:Object):void
		{
			if (p.hasOwnProperty('type')) type = p.type;
			if (p.hasOwnProperty('tone')) tone = p.tone;
			if (p.hasOwnProperty('desc')) desc = p.desc;
			if (p.hasOwnProperty('adj'))  adj  = p.adj;
			if (p.hasOwnProperty('furColor')) furColor = p.furColor;
		}

		public function setAllProps(p:Object, keepTone:Boolean = true):void
		{
			restore(keepTone);
			setProps(p);
		}


		override protected function saveToOldSave(savedata:Object):void {
			savedata.skinType    = type;
			savedata.skinDesc    = desc;
			savedata.skinAdj     = adj;
			savedata.skinTone    = tone;
			savedata.furColor    = furColor;
		}
		override protected function loadFromOldSave(savedata:Object):void {
			type = intOr(savedata.skinType, SKIN_TYPE_PLAIN);
			adj = stringOr(savedata.skinAdj, "");
			tone = stringOr(savedata.skinTone, "albino");
			desc = stringOr(savedata.skinDesc, Appearance.DEFAULT_SKIN_DESCS[type]);
			//Silently discard SKIN_TYPE_UNDEFINED
			if (type == SKIN_TYPE_UNDEFINED)
			{
				adj = "";
				desc = "skin";
				type = SKIN_TYPE_PLAIN;
			}
			//Convert from old skinDesc to new skinAdj + skinDesc!
			if (desc.indexOf("smooth") != -1)
			{
				adj = "smooth";
				desc = Appearance.DEFAULT_SKIN_DESCS[type];
			}
			if (desc.indexOf("thick") != -1)
			{
				adj = "thick";
				desc = Appearance.DEFAULT_SKIN_DESCS[type];
			}
			if (desc.indexOf("rubber") != -1)
			{
				adj = "rubber";
				desc = Appearance.DEFAULT_SKIN_DESCS[type];
			}
			if (desc.indexOf("latex") != -1)
			{
				adj = "latex";
				desc = Appearance.DEFAULT_SKIN_DESCS[type];
			}
			if (desc.indexOf("slimey") != -1)
			{
				adj = "slimey";
				desc = Appearance.DEFAULT_SKIN_DESCS[type];
			}
		}

	}
}
