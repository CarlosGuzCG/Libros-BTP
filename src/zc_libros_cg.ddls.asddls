@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Libros'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

@Metadata.allowExtensions: true

define view entity ZC_LIBROS_CG
  as select from    ztb_libros_cg   as Libros
    inner join      ztb_catego_cg   as Catagoria on Libros.bi_categ = Catagoria.bi_categ
    left outer join ZC_CLNTS_LIB_CG as Ventas     on Libros.id_libro = Ventas.IdLibro
  association [0..*] to ZC_CLIENTES_CG as _Clientes on $projection.IdLibro = _Clientes.IdLibro
{
  key Libros.id_libro        as IdLibro,
      Libros.titulo          as Titulo,
      Libros.bi_categ        as Categoria,
      Libros.autor           as Autor,
      Libros.editorial       as Editorial,
      Libros.idioma          as Idioma,
      Libros.paginas         as Paginas,
      @Semantics.amount.currencyCode: 'Moneda'
      Libros.precio          as Precio,

      case
          when Ventas.Ventas < 1 then 0
          when Ventas.Ventas = 1 then 1
          when Ventas.Ventas = 2 then 2
          else 3
      end                    as Ventas,

      case Ventas.Ventas
          when 0 then ''
          else ''
          end                as Text,

      Libros.moneda          as Moneda,
      Libros.formato         as Formato,
      Catagoria.descripcion as Descripcion,
      Libros.url             as Url,
      _Clientes
}
