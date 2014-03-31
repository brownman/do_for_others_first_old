/*jshint strict:false*/
/*global CasperError, console, phantom, require*/

/**
 * Translation using the Google Translate Service.
 *
 * Usage:
 *
 *     $ casperjs translate.js --target=fr "hello world"
 *     bonjour tout le monde
 */

/*
 *casper.options.stepTimeout = timeout > 0 ? timeout : 1000;
 */


var system = require('system'),
    casper = require('casper').create(),
    format = require('utils').format,
    source = casper.cli.get('source') || 'auto',
    target = casper.cli.get('target'),
    text   = casper.cli.get(0),
    result;


/*
 *casper.echo("Testing with timeout=" + casper.options.stepTimeout + "ms, please be patient.");
 */

 casper.options.stepTimeout = 10000; //timeout > 0 ? timeout : 1000;

/*
 *casper.echo("Testing with timeout=" + casper.options.stepTimeout + "ms, please be patient.");
 */
if (!target) {
    casper.warn('The --target option is mandatory.').exit(1);
}

casper.start(format('http://translate.google.com/#%s/%s/%s', source, target, text), function() {
    this.fill('form#gt-form', {text: text});
}).waitForSelector('span.hps', function() {
    /*
     *this.echo(this.fetchText("#result_box"));
     */
/*
 *this.echo( ClientUtils.getElementInfo(this) );
 */
this.echo(this.getHTML("div#gt-res-dict"));
/*
 *this.echo(this.getElementInfo());
 */


     /*
      *this.echo("div#gt-res-dict");
      */
     /*
      *this.echo(this.fetchText("div#gt-res-dict"));
      */
}, null, 30000);


casper.run();
