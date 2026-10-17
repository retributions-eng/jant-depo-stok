# Jant Depo Stok Yönetimi

Mobil uyumlu ilk web uygulaması iskeleti. Supabase Auth ve PostgreSQL kullanır.

## Dosyalar
- `index.html`: giriş ekranı, ürün listesi, ürün oluşturma, stok giriş/çıkış, hareket geçmişi.
- `setup.sql`: ürün kodu otomatik üretimi için veritabanı fonksiyonu ve tetikleyici.

## Kurulum
1. Supabase SQL Editor'de `setup.sql` dosyasını çalıştırın.
2. `index.html` dosyasını GitHub deposuna yükleyin.
3. Supabase Project Settings → API bölümünden Project URL ve publishable key (eski projelerde anon public key) alın.
4. Uygulamayı açınca bu bilgileri girin. `service_role` veya secret key'i asla tarayıcıya koymayın.
5. Supabase Authentication → Users içindeki kullanıcı için parola ayarlayın; uygulamada e-posta ve kullanıcı parolasıyla giriş yapın.
6. İlk stok kaydından önce uygulamayı ve RLS politikalarını doğrulayın.

## Önemli
- GitHub Pages bir statik site sunar; Supabase veritabanı ayrı hizmettir.
- Bu başlangıç sürümünde ürün fotoğrafı yükleme ve Excel/PDF dışa aktarma henüz yok.
- SQL'in önceki adımlarında `products.current_stock` için update izni kaldırıldı. Bu yüzden stok yalnızca `stock_movements` üzerinden değişmelidir.
- Gerçek üretim kullanımından önce `stock_movements` için güvenli, transaction tabanlı stok güncellemesi ve ürün kodu üretimi test edilmelidir.
