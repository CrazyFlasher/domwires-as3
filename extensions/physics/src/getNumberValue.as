/**
 * Created by Anton Nefjodov on 20.05.2016.
 */
package
{
	public function getNumberValue(value:*):Number
	{
		if (value == "NaN")
		{
			return NaN;
		}

		return value as Number;
	}
}
