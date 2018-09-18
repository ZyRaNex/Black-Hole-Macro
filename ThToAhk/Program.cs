


using System;
using System.Net;
using System.Net.Sockets;
using System.IO;
using System.Text;
using System.Runtime.InteropServices;
using System.IO.MemoryMappedFiles;

public enum FileMapAccess
{
    FILE_MAP_COPY = 0x0001,
    FILE_MAP_WRITE = 0x0002,
    FILE_MAP_READ = 0x0004,
    FILE_MAP_ALL_ACCESS = 0x000F001F
}
enum FileMapProtection : uint
{
    PageReadonly = 0x02,
    PageReadWrite = 0x04,
    PageWriteCopy = 0x08,
    PageExecuteRead = 0x20,
    PageExecuteReadWrite = 0x40,
    SectionCommit = 0x8000000,
    SectionImage = 0x1000000,
    SectionNoCache = 0x10000000,
    SectionReserve = 0x4000000,
}

namespace ThToAhk
{


    class Program
    {

        public static void Main()
        {



            string MemoryMappedFileName = "Global\\ThToAhk";

            var mmf = MemoryMappedFile.CreateOrOpen(MemoryMappedFileName, 256);

            MemoryMappedViewAccessor accessor = mmf.CreateViewAccessor(0, 256);





            Console.WriteLine("Starting ThToAhk...");

            int port = 2206;
            TcpListener listener = new TcpListener(IPAddress.Loopback, port);
            listener.Start();

            Console.WriteLine("created listener");

            TcpClient client = listener.AcceptTcpClient();
            NetworkStream stream = client.GetStream();

            Console.WriteLine("created stream");

            byte[] myWriteBuffer;
            myWriteBuffer = new byte[256];

            while (true)
            {
                Array.Clear(myWriteBuffer, 0, myWriteBuffer.Length);
                stream.Read(myWriteBuffer, 0, myWriteBuffer.Length);


                //Console.WriteLine();
                //Console.WriteLine(myWriteBuffer);
                string asdf = System.Text.Encoding.Default.GetString(myWriteBuffer);

                Console.WriteLine(asdf);
                accessor.WriteArray(0, myWriteBuffer, 0, myWriteBuffer.Length);
            }
        }
    }
}
