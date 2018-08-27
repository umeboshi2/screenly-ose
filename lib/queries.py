
comma = ','.join

exists_table = "SELECT name FROM sqlite_master "
exists_table += "WHERE type='table' AND name='assets'"

remove = 'delete from assets where asset_id=?'


def quest(iterable):
    return '=?,'.join(iterable) + '=?'


def read_all(keys):
    return 'select {} from assets order by play_order'.format(comma(keys))


def read(keys):
    return "select {} from assets where asset_id=?".format(comma(keys))


def create(keys):
    tmpl = 'insert into assets ({}) values ({})'
    return tmpl.format(comma(keys), comma(['?'] * len(keys)))


def update(keys):
    return "update assets set {} where asset_id=?".format(quest(keys))
