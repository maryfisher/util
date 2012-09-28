package maryfisher.util {
    /**
     * NumberUtil provides common functions used with numbers and number formating.
     */
    public class NumberUtil {

    	/**
    	 * Adds a leading zero for numbers smaller than ten.
    	 * @param value Number to add leading zero
    	 * @return Number as a String. If number was smaller than ten it will have a leading zero
    	 * @example trace(NumberUtil.addLeadingZero(7)); // Traces 07
    	 */
    	public static function addLeadingZero(value:Number): String {
    		if (value<10) {
    			return '0'+int(value);
    		} else {
    			return String(int(value));
    		}
    	}

    	/**
		 * 	Formats a number.
		 *
		 *	@param value: The number you wish to format.
		 *	@param minLength: The minimum length of the number.
		 *	@param thousandsDelimiter: The character used to seperate thousands.
		 *	@param fillChar: The leading character used to make the number the minimum length.
		 *	@return Returns the formated number as a String.
		 *	@example
		 *		<code>
		 *			trace(NumberUtil.format(1234567, 8, ",")); // Traces 01,234,567
		 *		</code>
		 */
		public static function format(value:Number, thousandsDelimiter:String = ",",
				fillChar:String = null):String {
			var num:String = value.toString();
			var len:uint   = num.length;

			if (thousandsDelimiter != null) {
				var numSplit:Array = num.split('');
				var counter:uint = 3;
				var i:uint       = numSplit.length;

				while (--i > 0) {
					counter--;
					if (counter == 0) {
						counter = 3;
						numSplit.splice(i, 0, thousandsDelimiter);
					}
				}

				num = numSplit.join('');
			}

			//if (minLength != 0) {
				//if (len < minLength) {
					//minLength -= len;
//
					//var addChar:String = (fillChar == null) ? '0' : fillChar;
//
					//while (minLength--)
						//num = addChar + num;
				//}
			//}

			return num;
		} // function


		public static function equals(a: Number, b: Number, precision: Number = 0.001): Boolean {
			return (Math.abs(b - a) <= precision);
		}

		public static function randomIntBetween(min:int, max:int):int {
			var range:Number = max - min + 1;
			var result:Number = Math.floor( Math.random() * range ) + min;

			return int( result % int.MAX_VALUE );
		}

		public static function randomNumberBetween(min:Number, max:Number):Number {
			var range:Number = max - min;
			var result:Number = Math.random() * range + min;

			return result;
		}

		/**
		 * @param number the number to format
		 * @param maxDecimals count of decimal places
		 * @param forceDecimals show the decimal places if they are 0
		 * @param siStyle international system of units, true means 1.234,56 and false 1,234.56
		 */
		public static function numberFormat(number:*, maxDecimals:int = 2, forceDecimals:Boolean = false, siStyle:Boolean = true):String
		{
			var i:int = 0;
			var inc:Number = Math.pow(10, maxDecimals);
			var str:String = String(Math.round(inc * Number(number)) / inc);
			var hasSep:Boolean = str.indexOf(".") == -1;
			var sep:int = hasSep ? str.length:str.indexOf(".");
			var ret:String = (hasSep && !forceDecimals ? "":(siStyle ? ",":".")) + str.substr(sep + 1);
			if (forceDecimals)
			{
				for (var j:int = 0; j <= maxDecimals - (str.length - (hasSep ? sep - 1:sep)); j++)
				{
					ret += "0";
				}
			}
			while (i + 3 < (str.substr(0, 1) == "-" ? sep - 1:sep))
			{
				ret = (siStyle ? ".":",") + str.substr(sep - (i += 3), 3) + ret;
			}
			return str.substr(0, sep - i) + ret;
		}
    }
}
