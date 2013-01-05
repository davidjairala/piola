# encoding: utf-8
require 'spec_helper'

describe Piola::Splitting do

  describe '#to_arr' do

    it "should convert a string to an array" do
      txt = "foo bar baz\n\ntest\nwith enters"
      txt.to_arr.should eql(%w(foo bar baz test with enters))
    end

  end

  describe '#string_to_parragraph_arr' do

    it "should convert a string into an array of parragraphs" do
      txt = "  Normal\r 0\r \r \r \r \r false\r false\r false\r \r EN-US\r X-NONE\r X-NONE\n\n, edición del domingo 28 de octubre de 2012\n\nUna espesa neblina inunda los campos. Llovizna. Los vidrios de un autoferro se empañan y el frío entumece las manos. El clima no resulta favorable ese miércoles 24 de octubre. Así sucede; es cuestión de suerte, dicen. Si todo estuviera despejado, un imponente Chimborazo deslumbraría a las personas.\n\nLos más de 35 pasajeros, en su mayoría niños, están emocionados. Es su primera vez en un tren. Y van bien abrigados con suéteres, gorros de lana, bufandas y guantes. Es que el frío es intenso. Hace honor a la denominación de la ruta que recorre el autoferro: Tren del Hielo.\n\n  "
      txt.string_to_parragraph_arr.should eql(["Normal", "0", "false", "false", "false", "EN-US", "X-NONE", "X-NONE", "edición del domingo 28 de octubre de 2012", "Una espesa neblina inunda los campos Llovizna Los vidrios de un autoferro se empañan y el frío entumece las manos El clima no resulta favorable ese miércoles 24 de octubre Así sucede; es cuestión de suerte dicen Si todo estuviera despejado un imponente Chimborazo deslumbraría a las personas", "Los más de 35 pasajeros en su mayoría niños están emocionados Es su primera vez en un tren Y van bien abrigados con suéteres gorros de lana bufandas y guantes Es que el frío es intenso Hace honor a la denominación de la ruta que recorre el autoferro: Tren del Hielo"])
    end

  end

    describe '#string_to_important_parragraph_arr' do

      it 'returns unique lines only' do
        txt = "this is gonna be a repeated line\nthis is gonna be a repeated line\nanother line that should be unique"

        txt.string_to_important_parragraph_arr.should eql(["this is gonna be a repeated line", "another line that should be unique"])
      end

      it "should convert a string into an array of important parragraphs" do
        txt = "  Normal\r 0\r \r \r \r \r false\r false\r false\r \r EN-US\r X-NONE\r X-NONE\n\n, edición del domingo 28 de octubre de 2012\n\nUna espesa neblina inunda los campos. Llovizna. Los vidrios de un autoferro se empañan y el frío entumece las manos. El clima no resulta favorable ese miércoles 24 de octubre. Así sucede; es cuestión de suerte, dicen. Si todo estuviera despejado, un imponente Chimborazo deslumbraría a las personas.\n\nLos más de 35 pasajeros, en su mayoría niños, están emocionados. Es su primera vez en un tren. Y van bien abrigados con suéteres, gorros de lana, bufandas y guantes. Es que el frío es intenso. Hace honor a la denominación de la ruta que recorre el autoferro: Tren del Hielo.\n\n  "
        txt.string_to_important_parragraph_arr.should eql(["edición del domingo 28 de octubre de 2012", "Una espesa neblina inunda los campos Llovizna Los vidrios de un autoferro se empañan y el frío entumece las manos El clima no resulta favorable ese miércoles 24 de octubre Así sucede; es cuestión de suerte dicen Si todo estuviera despejado un imponente Chimborazo deslumbraría a las personas", "Los más de 35 pasajeros en su mayoría niños están emocionados Es su primera vez en un tren Y van bien abrigados con suéteres gorros de lana bufandas y guantes Es que el frío es intenso Hace honor a la denominación de la ruta que recorre el autoferro: Tren del Hielo"])
      end

      it 'should not include parragraphs with html leftovers' do
        txt = %Q{Presidente de la República estará en Azogues este viernes
  Miércoles 31 de Octubre de 2012 00:00
  El presidente de la República Rafael Correa llegará a la ciudad de Azogues este viernes en la tarde con el propósito de grabar el enlace ciudadano que se trasmitirá el sábado 3 de noviembre
  La visita del mandatario estaba confirmada hasta la tarde de ayer según informó la gobernadora del Cañar Bertha Molina
  La llegada del jefe de Estado a la capital provincial está prevista entre las 15:30 y 16:00 La grabación se llevará a cabo en el coliseo tipo mil ubicado en la Ciudadela del Chofer
  Desde la mañana del viernes en los alrededores del nuevo coliseo se instalará una feria ciudadana en la que se colocarán los diferentes estantes del Ejecutivo descentralizado en la jurisdicción cañari
  Según Molina la actividad que desarrollará el presidente figura como un acto de homenaje un saludo a San Francisco de Peleusí de Azogues y a sus habitantes
  A decir de la primera autoridad de la provincia el alcalde Eugenio Morocho deberá estar presente y ser un miembro activo en este evento pues el día de ayer iban a dialogar con la autoridad cantonal para solicitarle su participación
  Hasta ayer no se confirmó que el mandatario vaya a ofrecer alguna rueda de prensa o visite algún medio de comunicación tampoco se conoce sobre la agenda que vaya a tener luego de culminada la grabación del programa sabatino
  Personal encargado de los enlaces ciudadanos están desde ayer en la ciudad Para hoy se prevé que llegue todo el equipo y la seguridad del presidente
  Por su parte el Ministro del Interior José Serrano a
  los patios de la Sub Zona 3 del Comando de Policía del Cañar
  hará la entrega del uniformes (chaleco gorra y credencial) a cada uno 1 175
  /* Style Definitions */ table MsoNormalTable mso-style-name:"Tabla normal"; mso-tstyle-rowband-size:0; mso-tstyle-colband-size:0; mso-style-noshow:yes; mso-style-priority:99; mso-style-parent:""; mso-padding-alt:0cm 5 4pt 0cm 5 4pt; mso-para-margin:0cm; mso-para-margin-bottom: 0001pt; mso-pagination:widow-orphan; font-size:10 0pt; font-family:"Calibri" "sans-serif"; mso-bidi-font-family:"Times New Roman";
  /* Style Definitions */ table MsoNormalTable mso-style-name:"Tabla normal"; mso-tstyle-rowband-size:0; mso-tstyle-colband-size:0; mso-style-noshow:yes; mso-style-priority:99; mso-style-parent:""; mso-padding-alt:0cm 5 4pt 0cm 5 4pt; mso-para-margin-top:0cm; mso-para-margin-right:0cm; mso-para-margin-bottom:10 0pt; mso-para-margin-left:0cm; line-height:115%; mso-pagination:widow-orphan; font-size:11 0pt; font-family:"Calibri" "sans-serif"; mso-ascii-font-family:Calibri; mso-ascii-theme-font:minor-latin; mso-hansi-font-family:Calibri; mso-hansi-theme-font:minor-latin; mso-bidi-font-family:"Times New Roman"; mso-bidi-theme-font:minor-bidi; mso-fareast-language:EN-US;
  /* Style Definitions */ table MsoNormalTable mso-style-name:"Tabla normal"; mso-tstyle-rowband-size:0; mso-tstyle-colband-size:0; mso-style-noshow:yes; mso-style-priority:99; mso-style-parent:""; mso-padding-alt:0cm 5 4pt 0cm 5 4pt; mso-para-margin-top:0cm; mso-para-margin-right:0cm; mso-para-margin-bottom:10 0pt; mso-para-margin-left:0cm; line-height:115%; mso-pagination:widow-orphan; font-size:11 0pt; font-family:"Calibri" "sans-serif"; mso-ascii-font-family:Calibri; mso-ascii-theme-font:minor-latin; mso-hansi-font-family:Calibri; mso-hansi-theme-font:minor-latin; mso-bidi-font-family:"Times New Roman"; mso-bidi-theme-font:minor-bidi; mso-fareast-language:EN-US;}
        
        txt.string_to_important_parragraph_arr.should eql([
          "Presidente de la República estará en Azogues este viernes",
          "Miércoles 31 de Octubre de 2012 00:00",
          "El presidente de la República Rafael Correa llegará a la ciudad de Azogues este viernes en la tarde con el propósito de grabar el enlace ciudadano que se trasmitirá el sábado 3 de noviembre",
          "La visita del mandatario estaba confirmada hasta la tarde de ayer según informó la gobernadora del Cañar Bertha Molina",
          "La llegada del jefe de Estado a la capital provincial está prevista entre las 15:30 y 16:00 La grabación se llevará a cabo en el coliseo tipo mil ubicado en la Ciudadela del Chofer",
          "Desde la mañana del viernes en los alrededores del nuevo coliseo se instalará una feria ciudadana en la que se colocarán los diferentes estantes del Ejecutivo descentralizado en la jurisdicción cañari",
          "Según Molina la actividad que desarrollará el presidente figura como un acto de homenaje un saludo a San Francisco de Peleusí de Azogues y a sus habitantes",
          "A decir de la primera autoridad de la provincia el alcalde Eugenio Morocho deberá estar presente y ser un miembro activo en este evento pues el día de ayer iban a dialogar con la autoridad cantonal para solicitarle su participación",
          "Hasta ayer no se confirmó que el mandatario vaya a ofrecer alguna rueda de prensa o visite algún medio de comunicación tampoco se conoce sobre la agenda que vaya a tener luego de culminada la grabación del programa sabatino",
          "Personal encargado de los enlaces ciudadanos están desde ayer en la ciudad Para hoy se prevé que llegue todo el equipo y la seguridad del presidente",
          "Por su parte el Ministro del Interior José Serrano a",
          "los patios de la Sub Zona 3 del Comando de Policía del Cañar",
          "hará la entrega del uniformes (chaleco gorra y credencial) a cada uno 1 175"
        ])
      end

      it 'should not include parragraphs with mysql warnings' do
        txt = %Q{Warning: mysql_fetch_array() expects parameter 1 to be resource, boolean given in /nfs/c03/h06/mnt/51770/domains/sonorama.com.ec/html/sistema/noticias/cuarto_hora.php on line 113. Warning: mysql_free_result() expects parameter 1 to be resource, boolean given in /nfs/c03/h06/mnt/51770/domains/sonorama.com.ec/html/sistema/noticias/cuarto_hora.php on line 117.}
        txt.string_to_important_parragraph_arr.should eql([])
      end

      it 'should not include parragraphs with mysql errors' do
        txt = %Q{Error: mysql_fetch_array() expects parameter 1 to be resource, boolean given in /nfs/c03/h06/mnt/51770/domains/sonorama.com.ec/html/sistema/noticias/cuarto_hora.php on line 113. Warning: mysql_free_result() expects parameter 1 to be resource, boolean given in /nfs/c03/h06/mnt/51770/domains/sonorama.com.ec/html/sistema/noticias/cuarto_hora.php on line 117.}
        txt.string_to_important_parragraph_arr.should eql([])
      end

    end

end