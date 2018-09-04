
import java.util.Hashtable;
public class KWTable {

	private Hashtable mTable;
	public KWTable()
	{
		// Inicijalizcaija hash tabele koja pamti kljucne reci
		mTable = new Hashtable();
		mTable.put("PROGRAM", new Integer(sym.PROGRAM));
		mTable.put("VAR", new Integer(sym.VAR));
		mTable.put("INTEGER", new Integer(sym.INTEGER));
		mTable.put("CHAR", new Integer(sym.CHAR));
		mTable.put("BEGIN", new Integer(sym.BEGIN));
		mTable.put("END", new Integer(sym.END));
		mTable.put("READ", new Integer(sym.READ));
		mTable.put("WRITE", new Integer(sym.WRITE));
		mTable.put("IF", new Integer(sym.IF));
		mTable.put("THEN", new Integer(sym.THEN));
		mTable.put("ELSE", new Integer(sym.ELSE));
	}
	
	/**
	 * Vraca ID kljucne reci 
	 */
	
	public int find(String keyword)
	{
		Object symbol = mTable.get(keyword);
		if (symbol != null)
			return ((Integer)symbol).intValue();
		
		// Ako rec nije pronadjena u tebali kljucnih reci radi se o identifikatoru
		return sym.ID;
	}
	

}
