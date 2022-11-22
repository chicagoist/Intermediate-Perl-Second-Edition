# Python Wrapper for AbeBooks.com REST API

## Usage

Search book prices by ISBN:

```python
from abebooks import AbeBooks

ab = AbeBooks()
results = ab.getPriceByISBN(9780062941503)
if results['success']:
    best_new = results['pricingInfoForBestNew']
    best_used = results['pricingInfoForBestUsed']

# Best New Price
print(best_new['bestPriceInPurchaseCurrencyWithCurrencySymbol'])
# Best Used Price
print(best_used['bestPriceInPurchaseCurrencyWithCurrencySymbol'])
```

# Perl Wrapper for AbeBooks.com REST API

## Usage

```perl
use Abebooks;

# The module contains the functions '__get_price' and '__get_recomendations' -
# they are private. These functions return values in the JSON standard.

my $ade_script = Abebooks->new();
$ade_script->getPriceByISBN(9781449393090);
$ade_script->getRecommendationsByISBN(9781449393090);
$ade_script->getPriceByAuthorTitle('Schwartz, Randal L.', 'Learning Perl:');
$ade_script->getPriceByAuthorTitleBinding('Schwartz, Randal L.', 'Learning '.'Perl:', 'hard');
$ade_script->__get_price();
