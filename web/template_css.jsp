<link rel="stylesheet" type="text/css" href="css/bootstrap3.css">
<link rel="stylesheet" href="css/font-awesome.min.css">
<style type="text/css">
    body {
        height: 100%;
    }
    html {
        overflow-y:scroll;
        height: 100%;
    }

    /* Wrapper for page content to push down footer */
    #wrap {
        min-height: 100%;
        height: auto !important;
        height: 100%;
        /* Negative indent footer by it's height */
        margin: 0 auto -100px;
    }

    /* Set the fixed height of the footer here */
    #push,
    #footer {
        padding-top: 18px;
        height: 100px;
    }
    #footer {
        background-color: #f5f5f5;
    }

    /* Lastly, apply responsive CSS fixes as necessary */
    @media (max-width: 767px) {
        #footer {
            margin-left: -20px;
            margin-right: -20px;
            padding-left: 20px;
            padding-right: 20px;
        }
    }

    /* index.jsp */
    .hero-unit {
        padding: 90px 10px 120px;
        margin-bottom: 10px;
        font-size: 18px;
        font-weight: 200;
        line-height: 30px;
        color: inherit;
        background-color: #FFFFFF;
    }

    .hero-unit > h1 {
        font: 400 75px/1.3 'Berkshire Swash', Helvetica, sans-serif;
        color: #2b2b2b;
        text-shadow: 1px 1px 0px #ededed, 4px 4px 0px rgba(0, 0, 0, 0.15);
    }

    .hero-unit > p {
        font-family: 'Crimson Text', Georgia, Times, serif;
        font-size: 25px;
        line-height: 30px;
    }

    .col-md-3 > h3,
    .col-md-3 > p,
    .col-md-3 {
        text-align: center;
    }

    .col-md-3 > p {
        font: 400 16px/1.6 'Open Sans', Verdana, Helvetica, sans-serif;
    }

    .mycenter > a {
        text-decoration: none;
        color: #333333;
    }

    .mycenter > a:hover {
        text-decoration: none;
        color: #0088cc;
    }

    .well-pad {
        margin: 30px 10px 0px 10px;
    }
    .well-pad p {
        font-size: 17px;
    }

    /* repository */
    .panel-heading {
        padding: 5px 10px ;
        border-bottom: 1px solid transparent;
        border-top-right-radius: 3px;
        border-top-left-radius: 3px;
    }

    /* result table */
    #accordion a:link, #accordion a:visited {
        color: #E51400;
        text-decoration:none;
    }

    .navbar-inverse .navbar-brand {
        color: #ffffff;
    }
 
    /* search */
    .mainlabel {
        font-size: 23px;
        padding: .2em .4em .2em;
    }
    .well-search1 {
        padding: 40px 60px 10px 60px;
    }
    .well-search2 {
        padding-left: 60px ;
        padding-right: 10px ;
    }
    .searchbtn {
        padding: 6px 30px;
    }
    
    .list_col {
        padding-left: 25px ;
    }


    .banner { position: relative; overflow: auto; }
    .banner li { list-style: none; }
    .banner ul li { float: left; }

</style>
<!-- <link href="css/bootstrap-theme.css" rel="stylesheet"> -->