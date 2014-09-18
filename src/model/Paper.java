package model;

public class Paper {

    // bib info
    private String bib ;
    private String type ;

    // basic info
	private String author ;
	private String title ;
    // publication
    private String fullpublication ;
	private String publication ;
    private String abbr ;
    private String vol ;
    private String no ;
    private String pages ;
    private String year ;

    private String field ;
    private String doi ;
    private String abstra ;

    // bib citation for html
    private String bib_citation ;

	public Paper() {}

    // bib info
    public String getBib() {
        return bib ;
    }
    public void setBib( String a ) {
        this.bib = a ;
    }

    public String getType() {
        return type ;
    }
    public void setType( String a ) {
        this.type = a ;
    }

    // basic info
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

    /*
    @article : $publication, $vol($no): $pages, $years
    @inproceedings : $publication, pp.$pages, $years
    @phdthesis : $publication, $year
    @techreport : $publication, $no, $year
    @book : $publication, $year
    */
    public void setPublication(String pub, String abbr, String vol, String no, String pages, String year) {
        this.publication = pub ;
        this.abbr = abbr ;
        this.vol = vol ;
        this.no = no ;
        this.pages = pages ;
        this.year = year ;

        if( !abbr.equals("") )
            publication += " (" +  abbr + ")" ;

        if( type.equals("article") ) {
            fullpublication = publication + ", " + vol + "(" + no + "): " + pages + ", " + year ;
        }
        else if( type.equals("inproceedings") ) {
            fullpublication = publication + ", pp." + pages + ", " + year ;
        }
        else if( type.equals("phdthesis") || type.equals("book") ) {
            fullpublication = publication + ", " + year ;
        }
        else if( type.equals("techreport") ) {
            fullpublication = publication + ", " + no + ", " + year ;
        }
        else {
            fullpublication = publication ;
        }
    }
    public String getPublication() {
        return publication ;
    }
    public String getAbbr() { return abbr ; }
    public String getVol() { return vol ; }
    public String getNo() { return no ; }
    public String getPages() { return pages ; }
    public String getYear() { return year ; }
    public String getFullpublication() {
        return fullpublication ;
	}

	public String getField() {
		return field ;
	}
	public void setField( String a ) {
		this.field = a ;
	}

    public String getDoi() { return doi ; }
    public void setDoi( String a ) {
        if( a.equals("") )
            this.doi = "#" ;
        else
            this.doi = a ;
    }

    public String getAbstra() { return abstra ; }
    public void setAbstra( String a ) {
        if( a.equals("") )
            this.abstra = "available soon..." ;
        else
            this.abstra = a ;
    }

    //
    // bib citation for html
    //
    public String getBib_citation() {
        String data = "" ;
        /*
        @article{$bib,
            author = {$author},
            title = {$title},
            journal = {$publication},
            volume = {$vol},
            number = {$no},
            pages = {$pages},
            year = {$year},
            doi = {$doi}
        }
        */
        if( this.type.equals("article") ) {
            data += "@article{" + bib + ",<br/>" +
                    "&nbsp;&nbsp;&nbsp;&nbsp;author = {" + author + "},<br/>" +
                    "&nbsp;&nbsp;&nbsp;&nbsp;title = {" + title + "},<br/>" +
                    "&nbsp;&nbsp;&nbsp;&nbsp;journal = {" + publication + "},<br/>" +
                    "&nbsp;&nbsp;&nbsp;&nbsp;volume = {" + vol + "},<br/>" +
                    "&nbsp;&nbsp;&nbsp;&nbsp;number = {" + no + "},<br/>" +
                    "&nbsp;&nbsp;&nbsp;&nbsp;pages = {" + pages + "},<br/>" +
                    "&nbsp;&nbsp;&nbsp;&nbsp;year = {" + year + "},<br/>" +
                    "&nbsp;&nbsp;&nbsp;&nbsp;doi = {" + doi + "}<br/>" +
                    "}";
        }
        /*
        @inproceedings{$bib,
            author = {$author},
            title = {$title},
            booktitle = {$publication},
            pages = {$pages},
            year = {$year},
            doi = {$doi}
        }
        */
        else if( this.type.equals("inproceedings") ) {
            data += "@inproceedings{" + bib + ",<br/>" +
                    "&nbsp;&nbsp;&nbsp;&nbsp;author = {" + author + "},<br/>" +
                    "&nbsp;&nbsp;&nbsp;&nbsp;title = {" + title + "},<br/>" +
                    "&nbsp;&nbsp;&nbsp;&nbsp;booktitle = {" + publication + "},<br/>" +
                    "&nbsp;&nbsp;&nbsp;&nbsp;pages = {" + pages + "},<br/>" +
                    "&nbsp;&nbsp;&nbsp;&nbsp;year = {" + year + "},<br/>" +
                    "&nbsp;&nbsp;&nbsp;&nbsp;doi = {" + doi + "}<br/>" +
                    "}";
        }
        /*
        @phdthesis{$bib,
            author = {$author},
            title = {$title},
            school = {$publication},
            year = {$year}
        }
        */
        else if( this.type.equals("phdthesis") ) {
            data += "@inproceedings{" + bib + ",<br/>" +
                    "&nbsp;&nbsp;&nbsp;&nbsp;author = {" + author + "},<br/>" +
                    "&nbsp;&nbsp;&nbsp;&nbsp;title = {" + title + "},<br/>" +
                    "&nbsp;&nbsp;&nbsp;&nbsp;school = {" + publication + "},<br/>" +
                    "&nbsp;&nbsp;&nbsp;&nbsp;year = {" + year + "}<br/>" +
                    "}";
        }
        /*
        @techreport{$bib,
            author = {$author},
            title = {$title},
            institution = {$publication},
            number = {$no},
            year = {$year}
        }
        */
        else if( this.type.equals("techreport") ) {
            data += "@techreport{" + bib + ",<br/>" +
                    "&nbsp;&nbsp;&nbsp;&nbsp;author = {" + author + "},<br/>" +
                    "&nbsp;&nbsp;&nbsp;&nbsp;title = {" + title + "},<br/>" +
                    "&nbsp;&nbsp;&nbsp;&nbsp;institution = {" + publication + "},<br/>" +
                    "&nbsp;&nbsp;&nbsp;&nbsp;number = {" + no + "},<br/>" +
                    "&nbsp;&nbsp;&nbsp;&nbsp;year = {" + year + "}<br/>" +
                    "}";
        }
        else {
            data = "bib citation available soon..." ;
        }
        return data ;
    }

}