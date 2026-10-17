-- Jant Depo: otomatik ve benzersiz ürün kodu
-- Bu komut mevcut ürün/hareket kayıtlarını silmez.

create sequence if not exists public.product_code_seq start 1;

create or replace function public.assign_product_code()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  if new.product_code is null or btrim(new.product_code) = '' then
    new.product_code := 'JNT-' || lpad(nextval('public.product_code_seq')::text, 4, '0');
  end if;
  return new;
end;
$$;

drop trigger if exists products_assign_code on public.products;
create trigger products_assign_code
before insert on public.products
for each row execute function public.assign_product_code();

-- Kullanıcının product_code alanını sonradan değiştirmesini önlemek
revoke update on public.products from authenticated;
grant update (
  product_name, warehouse_location, length_mm, width_mm,
  thickness_mm, photo_url, description, material_group, updated_at
) on public.products to authenticated;

-- Stok miktarı, doğrudan ürün formundan değil hareket tetikleyicisinden değişir.
-- Daha önceki apply_stock_movement trigger'ı stok hesabını gerçekleştirir.
