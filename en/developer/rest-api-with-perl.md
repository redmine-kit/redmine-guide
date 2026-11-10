---
source: Rest_api_with_perl
source_url: https://www.redmine.org/projects/redmine/wiki/Rest_api_with_perl
source_version: 2
source_updated_on: '2016-03-12T08:05:55Z'
---

# Using the REST API with Perl

The followings are Perl scripts that demonstrate how to use the Redmine REST API. They guess file encodings from the locale environment variables. See [open](http://perldoc.perl.org/open.html) for more details.

## GET

```perl
#!/usr/bin/perl
#	restget : GET a representation of a REST resource
use strict;
use warnings;
use Getopt::Std;
use LWP::UserAgent;
use JSON;
use open ':locale';	# probe the locale environment variables like LANG

sub HELP_MESSAGE {
    print STDERR <<"EOM";
usage : $0 [-p] [-k API_KEY] url
        -p: pretty print
        -k API_KEY: API Access Key
EOM
    exit 0;
}
our ($opt_p, $opt_k);
getopts('pk:') or HELP_MESSAGE();
my $url = shift;
HELP_MESSAGE() unless $url;
#################################################
my $ua = new LWP::UserAgent;
$ua->timeout(10);	# default: 180sec
$ua->ssl_opts( verify_hostname => 0 );	# skip hostname verification
$ua->default_header('X-Redmine-API-Key' => $opt_k) if $opt_k;

my $res = $ua->get($url);
die $res->message if $res->is_error;

my $content =  $res->content;
utf8::decode($content);	# convert UTF-8 binary to text
if ($opt_p) {		# pretty print
    my $perl_ref = from_json($content);
    print to_json($perl_ref, {pretty=>1});
} else {
    print $content, "\n";
}
exit 0;
```

Note:

```text
my $perl_ref = from_json($content);
```

Here a [Perl reference](http://perldoc.perl.org/perlref.html") `$perl_ref` is a reference to a whole data structure parsed.

Usage examples:

```text
./restget http://www.redmine.org/issues/22097.json
./restget -k 57acc39afc967564aa79a6bd329897d7040a9bc8 http://demo.redmine.org/issues/117594.json
```

The next commands put a textile table into the clipboard.

```text
./restget http://www.redmine.org/projects/redmine/versions.json | perl -MJSON -nle 'for $v (sort{$a->{name} cmp $b->{name}}@{decode_json($_)->{versions}}){$d=$v->{description};print qq/|version:"$v->{name}"|$d|/ if $d}' > /dev/clipboard
```

You can paste it on your Wiki page as follows.

|  |  |
|----|----|
| [0.7.1](https://www.redmine.org/versions/3) | Bug fix release |
| 0.7.2 | Bug fix release |
| 0.7.3 | Security+Bug fix release |
| [0.9.0](https://www.redmine.org/versions/6) | 0.9 release candidate 1 |
| 0.9.6 | Security release |
| 1.0.1 | Bug fixes for the 1.0.0 RC - (Estimated release date) |
| 1.2.3 | Bug fix release for the 1.2.x serie |
| 1.3.1 | Maintenance release |
| 1.4.3 | Maintenance release |
| 1.4.7 | security release |
| 2.0.2 | Maintenance release |
| 2.6.10 | For Rails 3.2 due to JRuby Nokogiri/Loofah does not support Rails 4.2 |
| Candidate for next major release | Features that the contributors would like to add in the next major version |
| Candidate for next minor release | Fixes that the contributors would like to add in the next minor version |
| Unplanned | Features that the core contributors of Redmine would like to add in a future version |

## PUT

```perl
#!/usr/bin/perl
#	restput : PUT a representation of a REST resource
use strict;
use warnings;
use Getopt::Std;
use LWP::UserAgent;
use open ':locale';	# probe the locale environment variables like LANG

sub HELP_MESSAGE {
    print STDERR <<"EOM";
usage : $0 [-p API_KEY] url [files...]
        -k API_KEY: API Access Key
EOM
    exit 0;
}
our ($opt_k);
getopts('k:') or HELP_MESSAGE();
my $url = shift;
HELP_MESSAGE() unless $url;
#################################################
my $ua = new LWP::UserAgent;
$ua->timeout(10);	# default: 180sec
$ua->ssl_opts( verify_hostname => 0 );	# skip hostname verification
$ua->default_header('X-Redmine-API-Key' => $opt_k) if $opt_k;

my $content;
{
    local $/;
    $content = <>;	# gets whole input
}
utf8::encode($content);	# convert UTF-8 binary to text
my $res = $ua->put($url,
                   'Content-Type' => 'application/json;charset=utf-8',
                   'Content' => $content);
die $res->message if $res->is_error;
print $res->content();
exit 0;
```

Usage examples:

```text
# change my name
echo '{"user":{"firstname":"James","lastname":"Bond"}}' | ./restput -k 57acc39afc967564aa79a6bd329897d7040a9bc8 http://demo.redmine.org/users/current.json
```

The following script converts a Wiki content to JSON format.

```perl
#!/usr/bin/perl
#	restwiki : convert a Wiki content to JSON format
use strict;
use warnings;
use Getopt::Std;
use JSON;
use open ':locale';

sub HELP_MESSAGE {
    print STDERR <<"EOM";
usage :    $0 [-c comment] [files...]
    -c : comment
EOM
    exit 0;
}
our ($opt_c);
getopts('c:') or HELP_MESSAGE();
#################################################
my $ref;
{
    local $/;	# enable slurp mode
    $ref->{wiki_page}->{text} = <>;
}
$ref->{wiki_page}->{comments} = $opt_c if $opt_c;
print to_json($ref);
exit 0;
```

The following commands create or update a Wiki page “Test Page”.

```text
./restwiki foo | ./restput -k 57acc39afc967564aa79a6bd329897d7040a9bc8 http://my.redmine.local/projects/test-project/wiki/Test_Page.json
```

You, a one-liner, may want to do as follows;

```text
perl -MJSON -e 'local $/;$ref->{wiki_page}->{text} = <>;print to_json($ref)' foo | ./restput -k 57acc39afc967564aa79a6bd329897d7040a9bc8 http://my.redmine.local/projects/test-project/wiki/Test_Page.json
```

## Resources

- [LWP::UserAgent](http://search.cpan.org/~ether/libwww-perl-6.15/lib/LWP/UserAgent.pm)
- [JSON](http://search.cpan.org/~makamaka/JSON-2.90/lib/JSON.pm)
- [perlref - Perl references and nested data structures](http://perldoc.perl.org/perlref.html)
- [perlunitut - Perl Unicode Tutorial](http://perldoc.perl.org/perlunitut.html)
