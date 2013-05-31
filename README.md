# Doabit Blog

http://doabit.com

[padrino][1] + [puma][2] + [nginx][3]

### Requirements

1. ruby 2.0.0-p195
2. sqlite3 (you also can use mysql or postgresql)
3. nginx

### Use

1. run `bundle install`
2. copy `config/app_config.example.yml` to `config/app_config.yml`, `config/database.example.yml` to `config/database.yml`, `config/deploy.example.rb` to `cofnig/deploy.rb`
3. Modify `database.yml,` `app_config.yml`
4. run `bundle exec rake ar:migrate`
5. run `bundle exec rake ar:seed`
6. Modify `deploy.rb` for yourself and run `bundle exec cap depoy:setup`
7. ssh to your host and modify files in `shared/config/` path


  [1]: https://github.com/padrino/padrino-framework
  [2]: https://github.com/puma/puma
  [3]: http://nginx.org/