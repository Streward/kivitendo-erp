# This file as been auto-generated only because it didn't exist.
# Feel free to modify it at will; it will not be overwritten automatically.

package SL::DB::Manager::PriceRule;

use strict;

use parent qw(SL::DB::Helper::Manager);

use SL::DB::Helper::Filtered;
use SL::DB::Helper::Paginated;
use SL::DB::Helper::Sorted;
use SL::DBUtils;

use SL::Locale::String qw(t8);

sub object_class { 'SL::DB::PriceRule' }

__PACKAGE__->make_manager_methods;
__PACKAGE__->add_filter_specs(
  has_item_type => sub {
    my ($key, $values, $prefix) = @_;
    return unless @$values;

    my $each_type = "SELECT DISTINCT price_rules_id FROM price_rule_items WHERE type = %s";
    my $sub_query = join ' INTERSECT ', map { sprintf $each_type, $::form->get_standard_dbh->quote($_) } @$values;
    return or => [ ${prefix} . 'id' => [ \$sub_query ] ];
  },
  item_type_matches => sub {
    my ($key, $values, $prefix) = @_;
    return unless @$values;
    return unless 'HASH' eq ref $values->[0];
    return unless grep $_, values %{ $values->[0] };

    my $each_type = "SELECT DISTINCT price_rules_id FROM price_rule_items WHERE type = %s AND (%s)";
    my $sub_query = join ' INTERSECT ', map {
      sprintf $each_type, $::form->get_standard_dbh->quote($_), SL::DB::Manager::PriceRuleItem->filter_match($_, $values->[0]{$_})
    } grep { $values->[0]{$_} } keys %{ $values->[0] };
    return or => [ ${prefix} . 'id' => [ \$sub_query ] ];
  },
);

sub get_matching_filter {
  my ($class, %params) = @_;

  die 'need record'      unless $params{record};
  die 'need record_item' unless $params{record_item};

  my $type = $params{record}->is_sales ? 'customer' : 'vendor';

  # plan: 1. search all rule_items that do NOT match this record/record item combo
  my ($sub_where, @values) = SL::DB::Manager::PriceRuleItem->not_matching_sql_and_values(type => $type, %params);

  # now union all NOT matching, invert ids, load these
  my $matching_rule_ids = <<SQL;
    SELECT id FROM price_rules
    WHERE id NOT IN (
      SELECT price_rules_id FROM price_rule_items WHERE $sub_where
    )
    AND type = ? AND NOT obsolete
SQL

  push @values, $type;

  return $matching_rule_ids, @values;
}

sub get_all_matching {
  my ($self, %params) = @_;

  my ($query, @values) = $self->get_matching_filter(%params);
  my @ids = selectall_ids($::form, $::form->get_standard_dbh, $query, 0, @values);

  return [] unless @ids;

  $self->get_all(query => [ id => \@ids ]);
}

sub _sort_spec {
  return ( columns => { SIMPLE => 'ALL', },
           default => [ 'name', 1 ],
           nulls   => { price => 'LAST', discount => 'LAST'  }
         );
}

1;