using System.Globalization;
using Turbo.Plugins.Default;
using System.Linq;

using System;
using System.Net;
using System.Net.Sockets;
using System.Text;

namespace Turbo.Plugins.Zy
{
    public class ThToAhkAdapter : BasePlugin, IInGameTopPainter
    {
		
        
        TcpClient client;
        NetworkStream stream;

        public ThToAhkAdapter()
        {
            Enabled = true;
        }

        public override void Load(IController hud)
        {
            base.Load(hud);

            int port = 2206;
            client = new TcpClient("localhost", port);
            if(Enabled) stream = client.GetStream();

			
            byte[] myWriteBuffer = Encoding.ASCII.GetBytes("Are you receiving this message?");
            if(Enabled) stream.Write(myWriteBuffer, 0, myWriteBuffer.Length);
            if(Enabled) stream.Flush();


            //writer.WriteLine("asdf");

        }

        public void PaintTopInGame(ClipState clipState)
        {
            if (Hud.Render.UiHidden) return;

            IBuff ConventionBuff;
            string Mana = "";
			string ConventionLight = "";
			string ConventionArcane = "";
			string ConventionCold = "";
			string ConventionFire = "";
			
			//int address=0;

            foreach (var player in Hud.Game.Players)
            {
                //if (player.ActorId == 0) continue;
				if(!player.IsMe) continue;
                ConventionBuff = player.Powers.GetBuff(430674);
				if ((ConventionBuff == null) || (ConventionBuff.IconCounts[0] <= 0)) continue;

                Mana = (Hud.Game.Me.Stats.ResourceCurArcane == Hud.Game.Me.Stats.ResourceMaxArcane).ToString();
                ConventionLight = ConventionBuff.IconCounts[5].ToString();
				ConventionArcane = ConventionBuff.IconCounts[1].ToString();
				ConventionCold = ConventionBuff.IconCounts[2].ToString();
				ConventionFire = ConventionBuff.IconCounts[3].ToString();
            }
            
			IBuff BlackholeBuff;
			string Blackhole = "";
			
			foreach (var player in Hud.Game.Players)
            {
                //if (player.ActorId == 0) continue;
				if(!player.IsMe) continue;
                
				BlackholeBuff = player.Powers.GetBuff(243141);
				if (BlackholeBuff == null) continue;
				if (BlackholeBuff.IconCounts[5] <= 0) continue;

                //Blackhole = BlackholeBuff.IconCounts[5].ToString();
				
				Blackhole = (BlackholeBuff.TimeLeftSeconds[5]>3.5).ToString();
            }
			

            string send="";
			
            if(Mana=="True") send+="1";
			else send+="0";
			
			
			if(ConventionLight=="1") send+="1";
			else send+="0";
			if(ConventionArcane=="1") send+="1";
			else send+="0";
			if(ConventionCold=="1") send+="1";
			else send+="0";
			if(ConventionFire=="1") send+="1";
			else send+="0";
			
			
			if(Blackhole=="True") send+="1";
			else send+="0";
			

            //byte[] myWriteBuffer = Encoding.ASCII.GetBytes(send.ToString());
			byte[] myWriteBuffer = Encoding.Unicode.GetBytes(send);
            if(Enabled) stream.Write(myWriteBuffer, 0, myWriteBuffer.Length);
            
        }

    }

}
