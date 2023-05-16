CLASS zcl_hello_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES:
      if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS:
      _write_hello
        RETURNING VALUE(rv_output) TYPE string.

ENDCLASS.



CLASS zcl_hello_class IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    out->write( me->_write_hello( ) ).
  ENDMETHOD.

  METHOD _write_hello.
    rv_output = 'Hello World!'.
  ENDMETHOD.

ENDCLASS.
