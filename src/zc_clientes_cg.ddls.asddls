@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CLIENTES'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZC_CLIENTES_CG
    as select from ztb_clientes_cg as Clientes
    inner join ztb_clnts_lib_cg as ClientesLib
        on Clientes.id_cliente = ClientesLib.id_cliente
{
    key Clientes.id_cliente as IdCliente,
    key ClientesLib.id_libro as IdLibro,
    Clientes.tipo_acceso as TipoAcceso,
    Clientes.nombre as Nombre,
    Clientes.apellidos as Apellidos,
    Clientes.email as Email,
    Clientes.url as Url,
    concat_with_space(Clientes.nombre,Clientes.apellidos,1) as NombreCompleto
}
