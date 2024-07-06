const unlink = require("node:fs").unlink;
const { spawn } = require("child_process");
const path = require("path");


const delay = (ms) => new Promise((res) => setTimeout(res, ms));

const programController = {
    getImageName: async (req, res) => {
        try {
        //     const uploadDir = "./assets";
        //     if (!fs.existsSync(uploadDir)) {
        //     fs.mkdirSync(uploadDir, {recursive: true});
        //    }
            const pythonPath = path.join(__dirname, "..", "detection.py");
            const pyProg = await spawn("python", [pythonPath, req.file.path]);
            let resultPath = "";
            resultPath = path.join(__dirname, "..", "assets", "cake.jpg");
            
            
            pyProg.stdout.on("data", async function (data) {
                await data.toString();
                // console.log(cakeName);
                // res.status(200).json({ message: cakeName });
                // res.status(200).sendFile("cake.jpg", path.join(__dirname, "..", "assets"));
                // res.write(data);
                // res.end("end");
                // res.status(200);
                // await delay(2000);
                // res.end()
                res.status(200).sendFile(resultPath);
                           
            });
                
                
            await delay(30000);
            unlink(req.file.path, (err) => {
                if (err) throw err;
                console.log(req.file.path + " was deleted");
            });            
            // await delay(10000);
            // unlink(resultPath, (err) => {
            //     if (err) throw err;
            //     console.log(resultPath + " was deleted");
            // });
            // unlink("assets", (err) => {
            //   if (err) throw err;
            //   console.log("imagePath.json was deleted");
            // });
        } catch (err) {
            console.log(err);
        }
    }
}

module.exports = programController;