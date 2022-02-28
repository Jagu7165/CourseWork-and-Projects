
//Character tile class (level 2)

public class CharacterTile extends Tile{
    protected char symbol;
	
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
