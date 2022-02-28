import java.util.HashMap;

//Character tile class (level 2)

public class CharacterTile extends Tile{
    protected char symbol;

    //create hashmap to store chineeese characters
    public static HashMap<Character, Character> map = new HashMap<>();

    //static initialization block to store all key value pairs for chinnese symbols
    static{
        map.put('1', '\u4E00');
        map.put('2', '\u4E8C');
        map.put('3', '\u4E09');
        map.put('4', '\u56DB');
        map.put('5', '\u4E94');
        map.put('6', '\u516D');
        map.put('7', '\u4E03');
        map.put('8', '\u516B');
        map.put('9', '\u4E5D');
        map.put('N', '\u5317');
        map.put('E', '\u6771');
        map.put('W', '\u897F');
        map.put('S', '\u5357');
        map.put('C', '\u4E2D');
        map.put('F', '\u767C');
    }

    //tochineese methood that returns the chineese symbol
    public String toChinese(){
        
        String chineese = Character.toString(map.get(symbol));

        return chineese;
    }
	
	public CharacterTile(char symbol) {
		this.symbol = symbol;
	}
	
	public boolean matches(Tile other) {
		super.matches(other);
		CharacterTile otherTile = (CharacterTile) other;
		
		if(this.symbol == otherTile.symbol)
        { 
            return true;
        }else
        {	
		return false;
        }
	}
	
    //return "Character + Symbol based on character value"
	public String toString() {

        if(symbol == 'N'){
            return "Character North Wind";
        }
        else if (symbol == 'E'){
            return "Character East Wind";
        }
        else if (symbol == 'W'){
            return "Character West Wind";
        }
        else if (symbol == 'S'){
            return "Character South Wind";
        }
        else if (symbol == 'C'){
            return "Character Red Dragon";
        }
        else if (symbol == 'F'){
            return "Character Green Dragon";
        }
        else{
            return "Character " + symbol;
        }
	}
}
