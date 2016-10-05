/**
 * ...
 * @author 
 */

class com.scaleform.udk.utils.UDKUtils 
{	
	//UDK Image set Path URL.
	public static var ClanMarkAniPath:String = "upk://Imgset_ClanMarkAni.";
	public static var WeaponImgPath:String   = "img://Imgset_Weapon.";
	public static var WeaponImgAniPath:String= "upk://Imgset_Weapon_Ani.";
	public static var ArmorImgPath:String    = "img://Imgset_Armor.";
	public static var CashImgPath:String     = "img://Imgset_CashItem.";
	public static var CashImgAniPath:String  = "upk://Imgset_CashItem_Ani.";
	public static var CamoImgPath:String     = "img://Imgset_Camo.";
	public static var CamoImgAniPath:String  = "upk://Imgset_Camo.";
	public static var CombatImgPath:String   = "upk://Imgset_Combat.";	
	public static var GachaImgPath:String    = "img://Imgset_GachaSelect_BigItem.";
	public static var GachaImgAniPath:String = "upk://Imgset_GachaSelect_BigItem.";	
	public static var MapImgPath:String      = "img://Imgset_Map.";
	public static var ModeImgPath:String     = "img://Imgset_Mode.";
	
	public static var weaponOptionArr:Array =  ["acog", "eotech", "silencer", "opendot", "acog", 
											    "laserpointer", "aimpoint", "crossbow", "s2s", 
											    "siis", "fan", "scope", "usas12", "heromode",
											    "luckybomb", "pirate", "pumpkin", "bluea", "blueb", "bluec",
												"reda", "redb", "redc",
											    "melee","explode","range","exp03"];
	
	public static function setDocumentClass(mc:MovieClip, cls:Object):Void {
		registerClass(mc, cls);
	}
	
	public static function registerClass(mc:MovieClip, cls:Object):Void {
		mc.__proto__ = cls.prototype;
		Function(cls).apply(mc, null);
	}
	
	
}