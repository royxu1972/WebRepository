package model;

public class Paper {

	private String author ;
	private String title ;
	private String publication ;
	private String year ;
	private String type ;
	private String area ;

	public Paper() {}

	public String getAuthor() {
		return author ;
	}
	public void setAuthor( String a ) {
		this.author = a ;
	}

	public String getTitle() {
		return title ;
	}
	public void setTitle( String a ) {
		this.title = a ;
	}

	public String getPublication() {
		return publication ;
	}
	public void setPublication( String a ) {
		this.publication = a ;
	}

	public String getYear() {
		return year ;
	}
	public void setYear( String a ) {
		this.year = a ;
	}

	public String getType() {
		return type ;
	}
	public void setType( String a ) {
		this.type = a ;
	}

	public String getArea() {
		return area ;
	}
	public void setArea( String a ) {
		this.area = a ;
	}
}