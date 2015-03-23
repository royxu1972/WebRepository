package model;

public class Paper {
    /*
    @type { bib,
        author = { author },
        title = { title },
        journal | booktitle | school = { publication (abbr) },
        pages = { page },
        year = { year },
        [vol] = { vol },
        [no] = { no },
        doi = { doi }
    }
    */
    // data
    private String bib ;
    private String type ;
	private String author ;
	private String title ;
    private String publication ;
    private String abbr ;
    private String vol ;
    private String no ;
    private String pages ;
    private String year ;
    private String doi ;
    private String field ;

    /*
    @article : $publication, $vol($no): $pages, $years
    @inproceedings : $publication, pp.$pages, $years
    @phdthesis : $publication, $year
    @techreport : $publication, $no, $year
    @book : $publication, $year
    */

	public Paper() {}

    // basic information
    public String getBib() { return bib ; }
    public void setBib( String a ) { this.bib = a ; }

    public String getType() { return type ;}
    public void setType( String a ) { this.type = a ;}

	public String getAuthor() { return author ; }
	public void setAuthor( String a ) { this.author = a ; }

	public String getTitle() { return title ; }
	public void setTitle( String a ) { this.title = a ; }

    public String getPublication() { return publication ; }
    public void setPublication( String a ) { this.publication = a ; }

    public String getAbbr() { return abbr ; }
    public void setAbbr( String a ) { this.abbr = a ; }

    public String getVol() { return vol ; }
    public void setVol( String a ) { this.vol = a ; }

    public String getNo() { return no ; }
    public void setNo( String a ) { this.no = a ; }

    public String getPages() { return pages ; }
    public void setPages( String a ) { this.pages = a ; }

    public String getYear() { return year ; }
    public void setYear( String a ) { this.year = a ; }

    public String getField() { return field ; }
    public void setField( String a ) { this.field = a ; }

    public String getDoi() { return doi ; }
    public void setDoi( String a ) { this.doi = a ; }

}