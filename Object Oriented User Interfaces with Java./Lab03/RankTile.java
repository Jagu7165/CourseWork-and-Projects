
//RankTile Class (Level 2)

public abstract class RankTile extends Tile {
	protected int rank;

	
	public RankTile(int rank) {
		this.rank = rank;
	}
	
	public boolean matches(Tile other) {
		if(this == other){
            return true;
        }

		if(other==null){
            return false;
        }
		
		if(getClass() != other.getClass()){

            return false;
        }

		RankTile otherTile = (RankTile) other;
		
		if(this.rank == otherTile.rank){
            return true;
        }else{
            return false;
        }
		
	}
}
