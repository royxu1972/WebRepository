package model;

public class Author {
    private String full_affiliation ;
    private String email ;
    private String homepage ;

    public Author() {}

    public String getFull_affiliation() { return full_affiliation; }
    public void setFull_affiliation( String a ) { this.full_affiliation = a ; }

    public String getEmail() { return email; }
    public void setEmail( String a ) { this.email = a ; }

    public String getHomepage() { return homepage; }
    public void setHomepage( String a ) { this.homepage = a ; }

}
